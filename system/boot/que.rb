# frozen_string_literal: true

Svejk::Container.finalize :que do |container|
  init do
    require 'que'

    use :monitor
    use :rom
  end

  start do
    Que.logger = container['logger']
    Que.mode = :off
    Que.connection = container['persistence.db']
  end
end
