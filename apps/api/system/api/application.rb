# frozen_string_literal: true

require 'dry/web/roda/application'
require_relative 'container'

module Api
  class Application < Dry::Web::Roda::Application
    configure do |config|
      config.container = Container
      config.routes = 'web/routes'
    end

    opts[:root] = Pathname(__FILE__).join('../..').realpath.dirname

    plugin :json_parser
    plugin :default_headers, 'Content-Type' => 'application/json'
    plugin :request_headers

    plugin :disallow_file_uploads
    plugin :head
    plugin :heartbeat

    route do |r|
      r.multi_route

      r.root do
        '{}'
      end
    end

    load_routes!
  end
end
