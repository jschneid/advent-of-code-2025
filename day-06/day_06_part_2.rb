def cephalopod_values_from_lines(lines)
  operator_line = lines[-1]
  number_lines = lines[0..-2]

  operator_positions = find_operator_positions(operator_line)
  column_ranges = build_column_ranges(operator_positions, operator_line.size)

  column_ranges.map do |column_range|
    extract_vertical_numbers(number_lines, column_range)
  end
end

def find_operator_positions(operator_line)
  operator_line.to_enum(:scan, /\S/).map { Regexp.last_match.begin(0) }
end

def build_column_ranges(operator_positions, line_width)
  # Add a boundary past the end of the line to simplify range calculation
  boundaries = operator_positions + [line_width + 1]

  boundaries.each_cons(2).map do |start_pos, end_pos|
    start_pos..(end_pos - 2)
  end
end

def extract_vertical_numbers(number_lines, column_range)
  # Read vertically down the column at each x-index in the column_range
  column_range.map do |column_index|
    number_lines.map { |line| line[column_index] }.join.to_i
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
