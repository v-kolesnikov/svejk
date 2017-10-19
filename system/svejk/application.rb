# frozen_string_literal: true

require 'dry/web/roda/application'
require_relative 'container'

module Svejk
  class Application < Dry::Web::Roda::Application
    configure do |config|
      config.container = Container
    end

    use Rollbar::Middleware::Rack

    route do |r|
      r.run ::Api::Application.freeze.app
    end

    error do |e|
      self.class[:rack_monitor].instrument(:error, exception: e)
      raise e
    end
  end
end
