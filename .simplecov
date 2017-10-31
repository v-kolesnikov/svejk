# frozen_string_literal: true

SimpleCov.start do
  add_filter '/spec/'
  add_group 'API', 'apps/api'
  add_group 'Worker', 'apps/worker'
  add_group 'Lib', 'lib'
  add_group 'System', 'system'
end
