def columns_from_lines(lines)
  columns = Array.new(lines[0].split.size) { [] }
  lines.each do |line|
    values = line.split
    values.each_with_index do |value, index|
      columns[index] << value
    end
  end
  columns
end

def solve_column(column)
  operands = column[0..-2].map(&:to_i)
  if column[-1] == '+'
    operands.sum
  else
    operands.reduce(:*)
  end
end

lines = File.readlines('day-06/input.txt')
columns = columns_from_lines(lines)
p columns.map { |column| solve_column(column) }.sum
