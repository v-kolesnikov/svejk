# frozen_string_literal: true

require 'que'
require 'worker/container'

module Worker
  class Enqueue
    class Job < Que::Job
      def run(identifier, *args)
        Worker::Container['core.persistence.db'].transaction do
          operation = Worker::Container[identifier]
          operation.(*args)
        end
      end
    end

    def call(operation:, args:)
      Job.enqueue(operation, *args)
    end
  end
end
