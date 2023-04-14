require "./lib/exchange_simulator/result"

RSpec.describe ExchangeSimulator::Result do
  describe "#initialize" do
    context "when result and error are not given" do
      it "sets result to nil" do
        result = described_class.new
        expect(result.result).to be_nil
      end

      it "sets error to nil" do
        result = described_class.new
        expect(result.error).to be_nil
      end
    end

    context "when result is given" do
      it "sets result to the given value" do
        result = described_class.new(result: 42)
        expect(result.result).to eq(42)
      end

      it "sets error to nil" do
        result = described_class.new(result: 42)
        expect(result.error).to be_nil
      end
    end

    context "when error is given" do
      it "sets result to nil" do
        result = described_class.new(error: "something went wrong")
        expect(result.result).to be_nil
      end

      it "sets error to the given value" do
        result = described_class.new(error: "something went wrong")
        expect(result.error).to eq("something went wrong")
      end
    end
  end

  describe "#success?" do
    context "when error is nil" do
      it "returns true" do
        result = described_class.new(result: 42)
        expect(result.success?).to be true
      end
    end

    context "when error is not nil" do
      it "returns false" do
        result = described_class.new(error: "something went wrong")
        expect(result.success?).to be false
      end
    end
  end
end
