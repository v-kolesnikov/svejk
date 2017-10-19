require "dry/web/container"

module Svejk
  class Container < Dry::Web::Container
    configure do
      config.name = :svejk
      config.listeners = true
      config.default_namespace = "svejk"
      config.auto_register = %w[lib/svejk]
    end

    load_paths! "lib"
  end
end
