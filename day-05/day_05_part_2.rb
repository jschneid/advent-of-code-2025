def fresh_ranges_from_input
  fresh_ranges = []
  File.foreach('day-05/input.txt') do |line|
    if line.include?('-')
      range = line.split('-').map(&:to_i)
      fresh_ranges << range
    end
  end
  fresh_ranges
end

# Collapse the list of fresh ranges into a smaller list that
# contains no overlaps. This is so that we can then just sum
# the delta of each range to get the total count of fresh IDs,
# without having to iterate through every individual ID (like
# we did in Part 1).
def collapse_fresh_ranges(fresh_ranges)
  sorted_ranges = fresh_ranges.sort_by { |range| range[0] }
  collapsed_ranges = [sorted_ranges.delete_at(0)]

  sorted_ranges.each do |range|
    previous_range = collapsed_ranges.last
    if range[0] <= previous_range[1]
      previous_range[1] = [previous_range[1], range[1]].max
    else
      collapsed_ranges << range
    end
  end

  collapsed_ranges
end

def ingredient_id_in_fresh_ranges(fresh_ranges)
  fresh_ranges.sum { |range| range[1] - range[0] + 1 }
end

fresh_ranges = fresh_ranges_from_input
fresh_ranges = collapse_fresh_ranges(fresh_ranges)

p ingredient_id_in_fresh_ranges(fresh_ranges)
