# frozen_string_literal: true

require 'svejk/repository'

module Worker
  module Persistence
    module Repositories
      class Webhooks < Svejk::Repository[:webhooks]
        def by_event(event)
          by_events([event])
        end

        def by_events(events)
          webhooks.subscribed_to(events).to_a
        end

        def retrieve(id)
          webhooks.by_pk(id).one
        end
      end
    end
  end
end
