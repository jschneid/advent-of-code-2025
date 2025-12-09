def largest_character_index(bank)
  largest_character = '0'
  largest_index = -1
  bank.each_char.with_index do |char, index|
    if char > largest_character
      largest_character = char
      largest_index = index
    end
  end

  largest_index
end

def largest_joltage(bank)
  first_digit_index = largest_character_index(bank)
  if first_digit_index == bank.length - 1
    second_digit_index = first_digit_index
    first_digit_index = largest_character_index(bank[0..-2])
  else
    second_digit_index = first_digit_index + 1 + largest_character_index(bank[first_digit_index + 1..])
  end

  "#{bank[first_digit_index]}#{bank[second_digit_index]}".to_i
end

total_joltage = 0
File.foreach('day-03/input.txt') do |bank|
  total_joltage += largest_joltage(bank.chomp)
end

p total_joltage
