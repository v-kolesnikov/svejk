# frozen_string_literal: true

module Persistence
  module Relations
    class Webhooks < ROM::Relation[:sql]
      schema(:webhooks) do
        attribute :id, Types::Serial

        attribute :name, Types::Strict::String
        attribute :url,  Types::Strict::String
        attribute :secret_key, Types::Strict::String.optional
        attribute :events, Types::PG::Array('text')
      end

      view :subscribed_to do
        schema do
          new([relations[:webhooks][:id].qualified])
        end

        relation do |event_scope|
          webhooks.where { events.contain(event_scope) }
        end
      end
    end
  end
end
