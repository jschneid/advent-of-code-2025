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

def forklift_accessible_paper_locations
  locations = []
  @rows.each_with_index do |row, row_index|
    row.each_char.with_index do |char, column_index|
      next unless char == '@'

      adjacent_count = adjacent_papers(row_index, column_index)
      locations << [row_index, column_index] if adjacent_count < 4
    end
  end

  locations
end

def remove_papers_at(locations)
  locations.each do |row_index, column_index|
    @rows[row_index][column_index] = '.'
  end
end

def papers_count
  @rows.reduce(0) do |sum, row|
    sum + row.count('@')
  end
end

@rows = File.readlines('day-04/input.txt')
initial_papers_count = papers_count

loop do
  removal_eligible_locations = forklift_accessible_paper_locations
  break if removal_eligible_locations.empty?

  remove_papers_at(removal_eligible_locations)
end

p initial_papers_count - papers_count
