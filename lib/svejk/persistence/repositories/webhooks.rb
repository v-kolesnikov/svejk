# frozen_string_literal: true

require 'svejk/repository'

module Svejk
  module Persistence
    module Repositories
      class Webhooks < Svejk::Repository[:webhooks]
        def retrieve(id)
          webhooks.by_pk(id).one
        end
        alias [] retrieve
      end
    end
  end
end
