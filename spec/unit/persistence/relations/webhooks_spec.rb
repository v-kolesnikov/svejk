# frozen_string_literal: true

require 'spec_helper'
require 'db_spec_helper'

RSpec.describe 'webhooks' do
  before do
    Factory[:webhook, events: %w[issue.opened]]
    Factory[:webhook, events: %w[issue.opened issue.updated]]
    Factory[:webhook, events: %w[issue.closed issue.updated]]
  end

  let(:webhooks) { rom.relations[:webhooks] }

  it 'subscribed_to' do
    expect(webhooks.subscribed_to(%w[issue.updated]).count).to eq 2
  end
end
