# frozen_string_literal: true

require 'spec_helper'
require 'db_spec_helper'

RSpec.describe Persistence::Relations::Webhooks do
  let(:webhooks) { rom.relations[:webhooks] }

  describe '#subscribed_to' do
    before do
      Factory[:webhook, events: %w[issue.opened]]
      Factory[:webhook, events: %w[issue.opened issue.updated]]
      Factory[:webhook, events: %w[issue.closed issue.updated]]
    end

    it 'returns restricted relation' do
      expect(webhooks.subscribed_to(%w[issue.updated]).count).to eq 2
    end
  end

  describe '#starting_after' do
    before { 3.times { Factory[:webhook] } }

    let(:ids) { webhooks.order(:id).pluck(:id) }

    it 'returns empty relation if arg is a max id' do
      expect(webhooks.starting_after(ids.max).exist?).to eq false
    end

    it 'returns rest of relation otherwise' do
      expect(webhooks.starting_after(ids.min).count).to eq 2
    end
  end

  describe '#ending_before' do
    before { 3.times { Factory[:webhook] } }

    let(:ids) { webhooks.order(:id).pluck(:id) }

    it 'returns empty relation if arg is a min id' do
      expect(webhooks.ending_before(ids.min).exist?).to eq false
    end

    it 'returns rest of relation otherwise' do
      expect(webhooks.ending_before(ids.max).count).to eq 2
    end
  end
end
