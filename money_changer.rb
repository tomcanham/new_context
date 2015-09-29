module MoneyChanger
  class Changer
    attr_reader :initial_value_in_dollars

    CURRENCIES = [
      {value_in_cents: 10000, friendly_name: "hundred dollar bill"},
      {value_in_cents: 5000, friendly_name: "fifty dollar bill"},
      {value_in_cents: 2000, friendly_name: "twenty dollar bill"},
      {value_in_cents: 1000, friendly_name: "ten dollar bill"},
      {value_in_cents: 500, friendly_name: "five dollar bill"},
      {value_in_cents: 200, friendly_name: "two dollar bill"},
      {value_in_cents: 100, friendly_name: "one dollar bill"},
      {value_in_cents: 50, friendly_name: "fifty cent piece"},
      {value_in_cents: 25, friendly_name: "quarter"},
      {value_in_cents: 10, friendly_name: "dime"},
      {value_in_cents: 5, friendly_name: "nickel"},
      {value_in_cents: 1, friendly_name: "penny", plural: "pennies"}
    ].freeze

    def initialize(initial_value_in_dollars)
      @initial_value_in_dollars = initial_value_in_dollars
    end

    def get_denominations
      sorted_currencies = CURRENCIES.sort {|a, b| b[:value_in_cents] <=> a[:value_in_cents]}
      remainder = @initial_value_in_dollars * 100
      string_results = []
      numeric_results = {}

      sorted_currencies.each do |this_denomination|
        this_count = (remainder / this_denomination[:value_in_cents]).to_i
        if (this_count > 0)
          string_results.push(pluralize(this_count, this_denomination))
          numeric_results[this_denomination[:value_in_cents]] = this_count
          remainder = remainder % this_denomination[:value_in_cents]
        end

        break if remainder == 0
      end

      string_result = string_results.join(", ")
      return numeric_results, string_result
    end

    private
    def pluralize(amount, denomination)
      if (amount == 1)
        "#{amount.to_s} #{denomination[:friendly_name]}"
      else
        if denomination[:plural]
          "#{amount.to_s} #{denomination[:plural]}"
        else
          "#{amount.to_s} #{denomination[:friendly_name] + 's'}"
        end
      end
    end
  end
end
