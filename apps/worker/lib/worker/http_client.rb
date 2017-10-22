# frozen_string_literal: true

require 'faraday'
require 'worker/import'

module Worker
  class HttpClient
    include Worker::Import['logger']

    def call(url, data = {}, options = {})
      request(:post, url, data, options)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.response :logger
        conn.adapter Faraday.default_adapter
      end
    end

    def request(method, url, data = {}, options = {})
      response = connection.send method, url do |req|
        req.body = data
        req.headers.update options.fetch(:headers, {})
      end

      [response.status, response.headers, response.body]
    end
  end
end
