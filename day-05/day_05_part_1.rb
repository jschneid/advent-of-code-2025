def fresh_ranges_and_ingredient_ids_from_input
  fresh_ranges = []
  ingredient_ids = []
  File.foreach('day-05/input.txt') do |line|
    next if line.strip.empty?

    if line.include?('-')
      range = line.split('-').map(&:to_i)
      fresh_ranges << range
    else
      ingredient_ids << line.to_i
    end
  end
  [fresh_ranges, ingredient_ids]
end

def ingredient_fresh?(fresh_ranges, ingredient_id)
  fresh_ranges.each do |range|
    return true if ingredient_id >= range[0] && ingredient_id <= range[1]
  end
  false
end

def fresh_ingredient_count(fresh_ranges, ingredient_ids)
  fresh_count = 0

  ingredient_ids.each do |ingredient_id|
    fresh_count += 1 if ingredient_fresh?(fresh_ranges, ingredient_id)
  end

  fresh_count
end

fresh_ranges, ingredient_ids = fresh_ranges_and_ingredient_ids_from_input
p fresh_ingredient_count(fresh_ranges, ingredient_ids)
