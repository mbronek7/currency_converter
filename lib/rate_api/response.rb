module RateApi
  class Response
    attr_reader :data, :error

    def initialize(data: nil, error: nil)
      @data = data
      @error = error
    end

    def success?
      error.nil?
    end
  end
end
