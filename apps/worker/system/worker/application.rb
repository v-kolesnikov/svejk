# frozen_string_literal: true

require_relative 'container'

module Worker
  class Application < Worker::Container
    def run(*)
      stop = false
      %w[INT TERM].each do |signal|
        trap(signal) { stop = true }
      end

      loop do
        sleep 0.1
        break if stop
      end
    end
  end
end
