# frozen_string_literal: true

module Persistence
  module Relations
    class Jobs < ROM::Relation[:sql]
      schema(:que_jobs) do
        attribute :priority,    Types::Strict::Int
        attribute :run_at,      Types::Strict::Time
        attribute :job_id,      Types::Serial
        attribute :job_class,   Types::Strict::String
        attribute :args,        Types::PG::JSON
        attribute :error_count, Types::Strict::Int
        attribute :last_error,  Types::Strict::String
        attribute :queue,       Types::Strict::String

        primary_key :queue, :priority, :run_at, :job_id
      end
    end
  end
end
