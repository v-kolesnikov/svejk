# frozen_string_literal: true

require 'svejk/container'

Svejk::Container.finalize!

webhooks = Svejk::Container['persistence.rom'].relations[:webhooks]

webhooks.command(:create).(
  name: 'Event notification',
  url: 'http://localhost/notify',
  events: %w[entity.created entity.updated]
)
