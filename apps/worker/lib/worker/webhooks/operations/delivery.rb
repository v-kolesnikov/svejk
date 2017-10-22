# frozen_string_literal: true

require 'svejk/operation'
require 'worker/import'

module Worker
  module Webhooks
    module Operations
      class Delivery < Svejk::Operation
        include Worker::Import['core.logger']
        include Worker::Import['http_client']
        include Worker::Import['persistence.repositories.webhooks']

        def call(id, payload = {})
          webhook = webhooks.retrieve(id)
          response = http_client.call(webhook.url, payload)
          logger.info "Webhook delivered: #{response}"
        end
      end
    end
  end
end
