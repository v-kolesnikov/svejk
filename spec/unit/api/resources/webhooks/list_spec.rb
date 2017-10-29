# frozen_string_literal: true

require 'spec_helper'
require 'api_spec_helper'
require 'db_spec_helper'

RSpec.describe Api::Resources::Webhooks::List do
  describe 'options' do
    subject(:resource) { described_class }

    describe '.default_page_size' do
      it { expect(resource.default_page_size).to eq 20 }
    end

    describe '.filterable_fields' do
      it { expect(resource.filterable_fields).to eq %i[url] }
    end
  end

  describe '#call' do
    subject(:response) do
      described_class.new.(params)
    end

    let(:params) { {} }

    context 'when there is not one' do
      it 'returns an empty array' do
        expect(JSON.parse(response)).to be_empty
      end
    end

    context 'when there are some' do
      before do
        Factory[:webhook, events: %w[issue.opened]]
        Factory[:webhook, events: %w[issue.opened issue.updated]]
        Factory[:webhook, events: %w[issue.closed issue.updated]]
      end

      it 'returns all as array' do
        expect(JSON.parse(response)).not_to be_empty
      end
    end

    context 'when :url parameter provided' do
      let(:params) { { url: 'https://example.com/hooks' } }

      before do
        Factory[:webhook, url: 'https://example.com/hooks']
        Factory[:webhook, url: 'https://example.com/hooks']
        Factory[:webhook, url: 'https://example.com/foobar']
      end

      it 'returns data restricted by url' do
        expect(JSON.parse(response).count).to eq 2
      end
    end

    context 'when :started_after parameter provided' do
      let(:webhooks) { Array.new(3) { Factory[:webhook] } }
      let(:params) { { starting_after: webhooks.first.id } }

      it 'returns data restricted by id' do
        expect(JSON.parse(response).count).to eq 2
      end
    end

    context 'when :ending_before parameter provided' do
      let(:webhooks) { Array.new(3) { Factory[:webhook] } }
      let(:params) { { ending_before: webhooks.last.id } }

      it 'returns data restricted by id' do
        expect(JSON.parse(response).count).to eq 2
      end
    end
  end
end
