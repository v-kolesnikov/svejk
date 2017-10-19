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

        attribute :created_at, Types::Strict::Time.optional
        attribute :updated_at, Types::Strict::Time.optional
      end
    end
  end
end
