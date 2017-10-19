# frozen_string_literal: true

Svejk::Container.finalize :rollbar do |container|
  init do
    require 'rollbar'
    require 'rollbar/middleware/rack'

    use :settings
  end

  start do
    Rollbar.configure do |config|
      config.disable_rack_monkey_patch = true
      config.access_token = container['settings'].rollbar_token
      config.environment = container.config.env
    end
  end
end
