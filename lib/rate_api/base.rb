require "oj"

module RateApi
  class Base
    ENDPOINT = "https://open.er-api.com".freeze

    def initialize(args = {})
      @endpoint = args.fetch(:endpoint, ENDPOINT)
    end

    private

    attr_reader :endpoint

    def endpoint_url(path)
      "#{endpoint}#{path}"
    end

    def success?(response)
      response[:result] != "error"
    end

    def extract_error(response)
      response[:"error-type"]
    end

    def parse(response)
      Oj.load(response.body, symbol_keys: true)
    end
  end
end
