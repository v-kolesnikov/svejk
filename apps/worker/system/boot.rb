# frozen_string_literal: true

require_relative 'worker/container'

Worker::Container.finalize!

require 'worker/application'
require 'worker/enqueue'
