require "./lib/rate_api/base"

RSpec.describe RateApi::Base do
  let(:base) { RateApi::Base.new }

  describe "#initialize" do
    it "sets the default endpoint" do
      expect(base.instance_variable_get(:@endpoint)).to eq(RateApi::Base::ENDPOINT)
    end

    it "allows the endpoint to be overridden" do
      base = RateApi::Base.new(endpoint: "https://api.example.com")
      expect(base.instance_variable_get(:@endpoint)).to eq("https://api.example.com")
    end
  end

  describe "#endpoint_url" do
    it "returns the full URL for a given path" do
      path = "/path/to/resource"
      url = "#{RateApi::Base::ENDPOINT}#{path}"
      expect(base.send(:endpoint_url, path)).to eq(url)
    end
  end

  describe "#success?" do
    it "returns true if the response result is not 'error'" do
      response = {result: "success"}
      expect(base.send(:success?, response)).to eq(true)
    end

    it "returns false if the response result is 'error'" do
      response = {result: "error"}
      expect(base.send(:success?, response)).to eq(false)
    end
  end

  describe "#extract_error" do
    it "returns the error type from the response" do
      response = {"error-type": "invalid_request"}
      expect(base.send(:extract_error, response)).to eq("invalid_request")
    end
  end

  describe "#parse" do
    it "parses the response body with Oj and returns a hash with symbol keys" do
      response = double("response", body: '{ "foo": "bar" }')
      expect(base.send(:parse, response)).to eq({foo: "bar"})
    end
  end
end
