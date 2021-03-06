# frozen_string_literal: true

require 'dry/web/settings'
require 'types'

module Svejk
  class Settings < Dry::Web::Settings
    setting :database_url,   Types::Strict::String.constrained(filled: true)
    setting :session_secret, Types::Strict::String.constrained(filled: true)
    setting :rollbar_token,  Types::Strict::String.constrained(filled: true)
  end
end
