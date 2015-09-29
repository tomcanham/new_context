require './money_changer'

include MoneyChanger

amount = 999.99
changer = Changer.new(amount)
numeric_results, string_results = changer.get_denominations

puts "The text result of getting the denominations for #{amount} is:\n\n"
puts "\t#{string_results}\n\n"

puts "The numeric results of getting the denominations for #{amount} is (values in cents):\n\n"
puts "\t#{numeric_results.inspect}"
