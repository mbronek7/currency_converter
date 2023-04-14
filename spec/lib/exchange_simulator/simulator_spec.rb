require "./lib/exchange_simulator/simulator"

RSpec.describe ExchangeSimulator::Simulator do
  subject(:simulator) { described_class.simulate(from_currency, amount, to_currency) }

  describe ".simulate" do
    let(:rates) { {USD: 1.0, EUR: 0.83} }

    context "when rate API returns success response" do
      let(:response) { double("Response", data: rates, success?: true, error: nil) }
      before { allow_any_instance_of(RateApi::Resources::Rates).to receive(:get).and_return(response) }

      context "when valid input is provided" do
        let(:from_currency) { "USD" }
        let(:amount) { 100 }
        let(:to_currency) { "EUR" }

        it "calculates exchange amount correctly" do
          simulation = subject
          expect(simulation.result).to eq(83.0)
        end
      end

      context "when invalid input is provided" do
        let(:from_currency) { "USD" }
        let(:amount) { 100 }
        let(:to_currency) { "JPY" }

        it "returns error message" do
          simulation = subject
          expect(simulation.result).to be_nil
          expect(simulation.success?).to eq(false)
          expect(simulation.error).to eq("couldn't find exchange ratio for: JPY")
        end
      end
    end

    context "when rate API returns error response" do
      let(:response) { double("Response", data: nil, success?: false, error: "external API error") }
      before { allow_any_instance_of(RateApi::Resources::Rates).to receive(:get).and_return(response) }

      let(:from_currency) { "USD" }
      let(:amount) { 100 }
      let(:to_currency) { "EUR" }

      it "returns error message" do
        simulation = subject
        expect(simulation.result).to be_nil
        expect(simulation.success?).to eq(false)
        expect(simulation.error).to eq("external API error")
      end
    end
  end
end
