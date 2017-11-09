# frozen_string_literal: true

require 'http'

module Svejk
  class HttpClient
    def call(url:, headers: {}, body: {})
      response = HTTP.headers(headers).post(url, body: body)
      parse_response(response)
    end

    def parse_response(response)
      {
        status: response.status,
        headers: response.headers.to_a,
        body: response.body.to_s
      }
    end
  end
end
