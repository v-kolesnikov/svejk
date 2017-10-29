# frozen_string_literal: true

require 'api/import'
require 'api/resource'

module Api
  module Resources
    module Webhooks
      class Create
        include Api::Resource
        include Api::Import['persistence.repositories.webhooks']

        request_schema do
          required(:name).filled(:str?)
          required(:url).filled(:str?)
          required(:events).each(:str?)
          optional(:secret_key).filled(:str?)
        end

        def call(params = {})
          validation = request_schema.(params)
          if validation.success?
            webhooks.create(validation.output).to_h.to_json
          else
            validation.errors(full: true).to_json
          end
        end
      end
    end
  end
end
