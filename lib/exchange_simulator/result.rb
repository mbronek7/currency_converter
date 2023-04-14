module ExchangeSimulator
  class Result
    attr_reader :result, :error

    def initialize(result: nil, error: nil)
      @result = result
      @error = error
    end

    def success?
      error.nil?
    end
  end
end
