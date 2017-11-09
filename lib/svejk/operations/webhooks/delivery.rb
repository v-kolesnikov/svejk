# frozen_string_literal: true

require 'svejk/import'
require 'svejk/operation'

require 'openssl'
require 'securerandom'

module Svejk
  module Operations
    module Webhooks
      class Delivery < Svejk::Operation
        include Svejk::Import[
          :http_client,
          :logger,
          :'persistence.repositories.deliveries',
          :'persistence.repositories.webhooks'
        ]

        attr_reader :webhook, :payload

        def self.default_headers
          {
            'Content-Type' => 'application/json',
            'User-Agent'   => 'Svejk-Hookshot'
          }
        end

        # @param [Integer] id Webhook ID
        # @param [String] payload Webhook payload data
        def call(id, payload)
          @payload = payload
          @webhook = webhooks.retrieve(id)

          response = http_client.(request)

          deliveries.create(
            id: delivery_id,
            webhook_id: webhook.id,
            request: request,
            response: response,
            created_at: Time.now
          )
        end

        def delivery_id
          @delivery_id ||= SecureRandom.uuid
        end

        def headers
          @headers ||= self.class.default_headers.dup.tap do |headers|
            headers['X-Svejk-Delivery'] = delivery_id

            if webhook.secret_key
              headers['X-Svejk-Signature'] = "sha1=#{sha1_signature}"
            end
          end
        end

        def sha1_signature
          @signature ||= OpenSSL::HMAC.hexdigest(
            OpenSSL::Digest.new('sha1'),
            webhook.secret_key,
            payload
          )
        end

        def request
          @request ||= {
            url: webhook.url,
            headers: headers,
            body: payload
          }
        end
      end
    end
  end
end
