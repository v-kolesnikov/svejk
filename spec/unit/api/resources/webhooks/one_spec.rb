# frozen_string_literal: true

require 'spec_helper'
require 'api_spec_helper'
require 'db_spec_helper'

RSpec.describe Api::Resources::Webhooks::One do
  describe '#call' do
    subject(:response) do
      described_class.new.(params)
    end

    context 'when there is not one' do
      let(:params) { { id: 1 } }

      it 'returns an empty object' do
        expect(JSON.parse(response)).to be_empty
      end
    end

    context 'when there is one' do
      let(:webhook) { Factory[:webhook] }
      let(:params) { { id: webhook.id } }

      it 'returns it as object' do
        expect(JSON.parse(response)).to be_kind_of(Hash)
      end
    end
  end
end
