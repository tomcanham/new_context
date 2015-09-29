require './money_changer'
require 'pry'

include MoneyChanger

RSpec.describe Changer do
  it "correctly calculates denominations down to cents" do
      changer = Changer.new(999.99)

      denominations, string_result = changer.get_denominations
      expect(denominations).to eq({
        10000 => 9,
        5000 => 1,
        2000 => 2,
        500 => 1,
        200 => 2,
        50 => 1,
        25 => 1,
        10 => 2,
        1 => 4
        })
  end

  it "stops when the balance is zero" do
    changer = Changer.new(999.95)

    denominations, string_result = changer.get_denominations
    expect(denominations).to eq({
      10000 => 9,
      5000 => 1,
      2000 => 2,
      500 => 1,
      200 => 2,
      50 => 1,
      25 => 1,
      10 => 2,
      })
  end

  it "produces the correct textual results" do
    changer = Changer.new(999.99)

    denominations, string_result = changer.get_denominations
    expect(string_result).to eq("9 hundred dollar bills, 1 fifty dollar bill, 2 twenty dollar bills, " +
    "1 five dollar bill, 2 two dollar bills, 1 fifty cent piece, 1 quarter, 2 dimes, 4 pennies")
  end

  context "pluralization" do
    it "pluralizes pennies correctly" do
      changer = Changer.new(0.04)

      denominations, string_result = changer.get_denominations
      expect(string_result).to eq("4 pennies")
    end

    it "singularizes penny correctly" do
      changer = Changer.new(0.01)

      denominations, string_result = changer.get_denominations
      expect(string_result).to eq("1 penny")
    end
  end
end
