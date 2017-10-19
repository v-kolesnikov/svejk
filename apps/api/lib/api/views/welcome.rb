# frozen_string_literal: true

require 'api/view/controller'

module Api
  module Views
    class Welcome < Api::View::Controller
      configure do |config|
        config.template = 'welcome'
      end
    end
  end
end
