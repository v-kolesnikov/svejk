# frozen_string_literal: true

require 'api/import'

module Api
  module Resources
    module Webhooks
      class List
        include Api::Import['persistence.repositories.webhooks']

        def call(_params = {})
          webhooks.listing.map(&:to_h).to_json
        end
      end
    end
  end
end
