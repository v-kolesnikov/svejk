# frozen_string_literal: true

module Persistence
  module Relations
    class Deliveries < ROM::Relation[:sql]
      schema(:deliveries) do
        attribute :id, Types::PG::UUID

        attribute :request,  Types::PG::JSONB
        attribute :response, Types::PG::JSONB.optional

        attribute :webhook_id, Types::Strict::Int
        attribute :created_at, Types::Strict::Time

        primary_key :id

        associations do
          belongs_to :webhook
        end
      end
    end
  end
end
