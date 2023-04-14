require "./lib/rate_api/base"
require "./lib/rate_api/response"
require "restclient"
require "pry"

module RateApi
  module Resources
    class Rates < Base
      def get(currency)
        response = RestClient::Request.execute(
          method: :get,
          url: endpoint_url("/v6/latest/#{CGI.escape(currency)}")
        )
        parsed_response = parse(response)
        return Response.new(data: parsed_response[:rates]) if success?(parsed_response)
        Response.new(error: extract_error(parsed_response))
      rescue RestClient::BadRequest, RestClient::NotFound
        Response.new(error: "external API error")
      end
    end
  end
end
