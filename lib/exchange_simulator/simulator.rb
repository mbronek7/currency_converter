require "./lib/rate_api/resources/rates"
require_relative "result"

module ExchangeSimulator
  module Simulator
    extend self

    def simulate(from_currency, amount, to_currency)
      rates_response = get_rates(from_currency)
      return Result.new(error: rates_response.error) unless rates_response.success?
      calculate_exchange_amount(rates_response.data, to_currency, amount)
    end

    private

    def get_rates(from_currency)
      RateApi::Resources::Rates.new.get(from_currency)
    end

    def get_ratio(rates, to_currency)
      ratio = rates[to_currency.to_sym]
      return Result.new(result: ratio) unless ratio.nil?
      Result.new(error: "couldn't find exchange ratio for: #{to_currency}")
    end

    def calculate_exchange_amount(rates, to_currency, amount)
      ratio_result = get_ratio(rates, to_currency)
      return ratio_result unless ratio_result.success?
      result = (ratio_result.result * amount.to_f).truncate(2)
      Result.new(result:)
    end
  end
end
