# frozen_string_literal: true

require 'spec_helper'
require 'db_spec_helper'

RSpec.describe Svejk::Operations::Webhooks::Delivery do
  subject(:delivery) do
    described_class.new.(webhook.id, payload)
  end

  let(:url)     { 'http://example.com/trap' }
  let(:payload) { '' }
  let(:webhook) { Factory[:webhook, url: url] }

  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'User-Agent'   => 'Svejk-Hookshot',
      'X-Svejk-Delivery' => /./
    }
  end

  before do
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(status: 200, body: '', headers: {})

    delivery
  end

  it { expect(WebMock).to have_requested(:post, url) }

  it 'persists delivery request data' do
    repo = Svejk::Container['persistence.repositories.deliveries']
    expect(repo[delivery.id]).to be
  end

  context 'when webhook has secret_key' do
    let(:secret_key) { SecureRandom.hex }
    let(:webhook) { Factory[:webhook, url: url, secret_key: secret_key] }

    let(:signature) do
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'),
                              webhook.secret_key, payload)
    end

    it do
      expect(WebMock).to have_requested(:post, url)
        .with(headers: { 'X-Svejk-Signature' => "sha1=#{signature}" })
    end
  end
end
