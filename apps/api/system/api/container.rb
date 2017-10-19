# frozen_string_literal: true

require 'pathname'
require 'dry/web/container'

module Api
  class Container < Dry::Web::Container
    require root.join('system/svejk/container')
    import core: Svejk::Container

    configure do |config|
      config.root = Pathname(__FILE__).join('../..').realpath.dirname.freeze
      config.logger = Svejk::Container[:logger]
      config.default_namespace = 'api'
      config.auto_register = %w[lib/api]
    end

    load_paths! 'lib'
  end
end
