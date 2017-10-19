# frozen_string_literal: true

Svejk::Container.finalize :settings do |container|
  init do
    require 'svejk/settings'
  end

  start do
    settings = Svejk::Settings.load(container.config.root, container.config.env)
    container.register 'settings', settings
  end
end
