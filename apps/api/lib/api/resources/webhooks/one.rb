# frozen_string_literal: true

require 'api/import'

module Api
  module Resources
    module Webhooks
      class One
        include Api::Import['persistence.repositories.webhooks']

        def call(id, _params = {})
          webhooks.retrieve(id).to_h.to_json
        end
      end
    end
  end
end
