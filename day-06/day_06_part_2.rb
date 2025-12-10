def cephalopod_values_from_lines(lines)
  operator_indexes = lines[-1].to_enum(:scan, /\S/).map { Regexp.last_match.begin(0) }

  # We will build a set of cephalopod values, with size equal to the number of operators.
  cephalopod_values = Array.new(operator_indexes.size) { [] }

  operator_indexes << lines[0].size + 1

  cephalopod_value_set_index = 0

  # Each operator appears in the input in the first x-index of each column of values.
  # Iterate over each column, as bounded by its start and end x-indexes.
  operator_indexes.each_cons(2) do |operator_index, next_operator_index|
    cephalopod_value_index = 0

    # In the current column, iterate over each x-index in the column.
    (operator_index..next_operator_index - 2).each do |x|
      cephalopod_values[cephalopod_value_set_index][cephalopod_value_index] = ''

      # At the current x-index, iterate over each line of number values from the input.
      (0..lines.size - 2).each do |y|

        # At this y,x position of the input, add the character to the cephalopod value
        # for this x-index, in the set of cephalopod values for this column.
        cephalopod_values[cephalopod_value_set_index][cephalopod_value_index] += lines[y][x]
      end
      cephalopod_value_index += 1
    end
    cephalopod_value_set_index += 1
  end

  cephalopod_values.map do |cephalopod_value_set|
    cephalopod_value_set.map(&:to_i)
  end
end

def solve_column(operands, operator)
  if operator == '+'
    operands.sum
  else
    operands.reduce(:*)
  end
end

lines = File.readlines('day-06/input.txt')
cephalopod_values = cephalopod_values_from_lines(lines)

operators = lines[-1].scan(/\S/)

total = 0
operators.each_with_index do |operator, index|
  total += solve_column(cephalopod_values[index], operator)
end
p total
