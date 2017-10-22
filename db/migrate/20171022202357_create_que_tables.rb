# frozen_string_literal: true

ROM::SQL.migration do
  change do
    Svejk::Container.start :que
    Que.migrate!
  end
end
