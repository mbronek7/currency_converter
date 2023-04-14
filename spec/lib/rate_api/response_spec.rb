require "./lib/rate_api/response"

RSpec.describe RateApi::Response do
  describe "#initialize" do
    it "sets the data attribute" do
      response = RateApi::Response.new(data: {foo: "bar"})
      expect(response.data).to eq({foo: "bar"})
    end

    it "sets the error attribute" do
      response = RateApi::Response.new(error: "An error occurred.")
      expect(response.error).to eq("An error occurred.")
    end
  end

  describe "#success?" do
    it "returns true if there is no error" do
      response = RateApi::Response.new(data: {foo: "bar"})
      expect(response.success?).to eq(true)
    end

    it "returns false if there is an error" do
      response = RateApi::Response.new(error: "An error occurred.")
      expect(response.success?).to eq(false)
    end
  end
end
