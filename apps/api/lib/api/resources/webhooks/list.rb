# frozen_string_literal: true

require 'api/import'
require 'api/resource'

module Api
  module Resources
    module Webhooks
      class List
        include Api::Resource
        include Api::Import['persistence.repositories.webhooks']

        default_page_size 20
        filterable_fields %i[url]

        request_schema do
          optional(:events).filled(:array?)
          optional(:url).filled(:str?)
          optional(:limit).filled(:int?, gteq?: 1)
          optional(:starting_after).filled(:int?)
          optional(:ending_before).filled(:int?)
        end

        def call(params = {})
          validation = request_schema.(params)

          if validation.success?
            data(validation.output).map(&:to_h).to_json
          else
            validation.errors(full: true).to_json
          end
        end

        def data(params)
          webhooks.listing(
            **params,
            filter_by: filterable_fields(params),
            limit: params.fetch(:limit, self.class.default_page_size)
          )
        end
      end
    end
  end
end
