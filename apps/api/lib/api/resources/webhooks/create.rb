# frozen_string_literal: true

require 'api/import'

module Api
  module Resources
    module Webhooks
      class Create
        include Api::Import['persistence.repositories.webhooks']

        def call(params)
          webhooks.create(params).to_h.to_json
        end
      end
    end
  end
end
