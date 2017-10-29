# frozen_string_literal: true

require 'svejk/repository'

module Api
  module Persistence
    module Repositories
      class Webhooks < Svejk::Repository[:webhooks]
        commands :create, update: :by_pk, delete: :by_pk

        def listing(events: [], filter_by: {}, **options)
          webhooks
            .filter(filter_by)
            .starting_after(options[:starting_after])
            .ending_before(options[:ending_before])
            .subscribed_to(events)
            .limit(options[:limit])
            .to_a
        end

        def retrieve(id)
          webhooks.by_pk(id).one
        end
      end
    end
  end
end
