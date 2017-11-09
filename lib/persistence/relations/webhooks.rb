# frozen_string_literal: true

module Persistence
  module Relations
    class Webhooks < ROM::Relation[:sql]
      schema(:webhooks) do
        associations do
          has_many :deliveries
        end

        attribute :id, Types::Serial

        attribute :name, Types::Strict::String
        attribute :url,  Types::Strict::String
        attribute :secret_key, Types::Strict::String.optional
        attribute :events, Types::PG::Array('text')
      end

      def starting_after(value)
        value ? where { id > value } : self
      end

      def ending_before(value)
        value ? where { id < value } : self
      end

      def subscribed_to(events)
        where(webhooks[:events].contain(events))
      end

      def filter(options = {})
        conditions = options.each_with_object({}) do |(attr, value), hash|
          hash[webhooks[attr].qualified] = value
        end

        where(conditions)
      end
    end
  end
end
