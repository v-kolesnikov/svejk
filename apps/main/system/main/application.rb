# frozen_string_literal: true

require 'dry/web/roda/application'
require_relative 'container'

module Main
  class Application < Dry::Web::Roda::Application
    configure do |config|
      config.container = Container
      config.routes = 'web/routes'
    end

    opts[:root] = Pathname(__FILE__).join('../..').realpath.dirname

    use Rack::Session::Cookie,
        key: 'main.session',
        secret: self['core.settings'].session_secret

    plugin :csrf, raise: true
    plugin :flash
    plugin :dry_view
    plugin :json

    route do |r|
      r.multi_route

      r.root do
        r.view 'welcome'
      end
    end

    load_routes!
  end
end
