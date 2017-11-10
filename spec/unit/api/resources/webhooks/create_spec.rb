# frozen_string_literal: true

require 'spec_helper'
require 'api_spec_helper'
require 'db_spec_helper'

RSpec.describe Api::Resources::Webhooks::Create do
  describe '#call' do
    subject(:response) do
      described_class.new.(params)
    end

    let(:params) do
      {
        name: Faker::Lorem.word,
        url: Faker::Internet.url,
        events: %w[events.created events.updated]
      }
    end

    it 'creates a new webhook' do
      expect(JSON.parse(response, symbolize_names: true))
        .to include(:id, :name, :url, :events)
    end
  end
end
