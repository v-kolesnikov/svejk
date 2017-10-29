# frozen_string_literal: true

require 'api/import'

module Api
  module Resources
    module Webhooks
      class One
        include Api::Resource
        include Api::Import['persistence.repositories.webhooks']

        request_schema do
          required(:id).filled(:int?)
        end

        def call(params = {})
          validation = request_schema.(params)

          if validation.success?
            data(validation.output).to_h.to_json
          else
            validation.errors(full: true).to_json
          end
        end

        def data(id:)
          webhooks.retrieve(id)
        end
      end
    end
  end
end
