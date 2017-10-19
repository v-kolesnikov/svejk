# frozen_string_literal: true

module Api
  class Application < Dry::Web::Roda::Application
    route 'webhooks' do |r|
      r.is do
        r.get  to: 'resources.webhooks.list',   call_with: [r.params]
        r.post to: 'resources.webhooks.create', call_with: [r.params]
      end

      r.on(:id) do |id|
        r.get    to: 'resources.webhooks.one',    call_with: [id, r.params]
        r.delete to: 'resources.webhooks.delete', call_with: [id, r.params]
      end
    end
  end
end
