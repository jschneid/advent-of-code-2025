def remove_least_important_battery(bank)
  largest_joltage_value = 0
  index_to_remove = -1

  (0..bank.length - 1).each do |index|
    bank_without_battery_at_index = bank.dup
    bank_without_battery_at_index.slice!(index)
    joltage = bank_without_battery_at_index.to_i
    if joltage > largest_joltage_value
      largest_joltage_value = joltage
      index_to_remove = index
    end
  end

  bank.slice!(index_to_remove)
  bank
end

def largest_joltage(bank)
  bank = remove_least_important_battery(bank) while bank.length > 12

  bank.to_i
end

total_joltage = 0
File.foreach('day-03/input.txt') do |bank|
  total_joltage += largest_joltage(bank.chomp)
end

p total_joltage
