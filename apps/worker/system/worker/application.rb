# frozen_string_literal: true

require_relative 'container'

module Worker
  class Application < Worker::Container
    def self.configure
      Que.worker_count  = (ENV['QUE_WORKER_COUNT']  || 4).to_i
      Que.wake_interval = (ENV['QUE_WAKE_INTERVAL'] || 2).to_f
      Que.mode          = :async

      at_exit do
        $stdout.puts "Finishing Que's current jobs before exiting..."
        Que.worker_count = 0
        Que.mode = :off
        $stdout.puts "Que's jobs finished, exiting..."
      end

      self
    end

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
