# frozen_string_literal: true

require 'svejk/repository'

module Svejk
  module Persistence
    module Repositories
      class Deliveries < Svejk::Repository[:deliveries]
        commands :create

        def retrieve(id)
          deliveries.by_pk(id).one
        end
        alias [] retrieve
      end
    end
  end
end
