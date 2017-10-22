# frozen_string_literal: true

require 'pathname'

module Worker
  class Container < Dry::Web::Container
    require root.join('system/svejk/container')

    import core: Svejk::Container

    configure do |config|
      config.root = Pathname(__FILE__).join('../..').realpath.dirname.freeze
      config.logger = Svejk::Container[:logger]
      config.default_namespace = 'worker'
      config.auto_register = %w[lib/worker]
    end

    load_paths! 'lib'
  end
end
