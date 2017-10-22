# frozen_string_literal: true

require_relative 'worker/container'

Worker::Container.finalize!

require 'worker/application'
require 'worker/enqueue'

Que.worker_count  = (ENV['QUE_WORKER_COUNT']  || 4).to_i
Que.wake_interval = (ENV['QUE_WAKE_INTERVAL'] || 2).to_f
Que.mode          = :async

at_exit do
  $stdout.puts "Finishing Que's current jobs before exiting..."
  Que.worker_count = 0
  Que.mode = :off
  $stdout.puts "Que's jobs finished, exiting..."
end
