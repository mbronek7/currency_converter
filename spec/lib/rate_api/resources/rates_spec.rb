require "./lib/rate_api/resources/rates"

RSpec.describe RateApi::Resources::Rates do
  subject(:rates_api) { described_class.new }

  describe "#get" do
    context "when the request is successful" do
      before do
        stub_request(:get, "https://open.er-api.com/v6/latest/USD")
          .to_return(
            status: 200,
            body: req_body,
            headers: {"content-type": "application/json"}
          )
      end

      let(:rates) do
        {
          USD: 1,
          AED: 3.6725
        }
      end

      let(:req_body) do
        {
          result: "success",
          rates: rates
        }.to_json
      end

      it "returns a successful response with the rates data" do
        result = subject.get("USD")
        expect(result.data).to eq(rates)
        expect(result.error).to be_nil
      end
    end

    context "when the request is not successful" do
      before do
        stub_request(:get, "https://open.er-api.com/v6/latest/AUSD")
          .to_return(
            status: 200,
            body: req_body,
            headers: {"content-type": "application/json"}
          )
      end

      let(:req_body) do
        {
          result: "error",
          "error-type": "unsupported-code"
        }.to_json
      end

      it "returns an error response with the error type" do
        result = subject.get("AUSD")
        expect(result.data).to be_nil
        expect(result.error).to eq("unsupported-code")
      end
    end

    context "when an exception in RestClient is raised" do
      before do
        allow(RestClient::Request).to receive(:execute).and_raise(RestClient::BadRequest)
      end

      it "returns an error response with a generic error message" do
        result = subject.get("USD")
        expect(result.error).to eq("external API error")
      end
    end
  end
end
