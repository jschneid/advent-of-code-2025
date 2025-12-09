def paper?(row_index, column_index)
  return false if row_index < 0 || column_index < 0 || row_index >= @rows.size || column_index >= @rows[0].size

  @rows[row_index][column_index] == '@'
end

def adjacent_papers(row_index, column_index)
  count = 0
  (row_index - 1..row_index + 1).each do |r|
    (column_index - 1..column_index + 1).each do |c|
      next if r == row_index && c == column_index

      count += 1 if paper?(r, c)
    end
  end

  count
end

def forklift_accessible_papers
  count = 0
  @rows.each_with_index do |row, row_index|
    row.each_char.with_index do |char, column_index|
      next unless char == '@'

      adjacent_count = adjacent_papers(row_index, column_index)
      count += 1 if adjacent_count < 4
    end
  end

  count
end

@rows = File.readlines('day-04/input.txt')
p forklift_accessible_papers
