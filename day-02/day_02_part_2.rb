def invalid?(id)
  id_string = id.to_s

  (1..id_string.length / 2).each do |size|
    next if id_string.length % size != 0

    pattern = id_string[0, size]
    repeated_pattern = pattern * (id_string.length / size)
    return true if repeated_pattern == id_string
  end

  false
end

def invalid_ids_in_range(min, max)
  invalid_ids = []
  (min..max).each do |id|
    invalid_ids << id if invalid?(id)
  end

  invalid_ids
end

invalid_ids = []
File.read('day-02/input.txt').split(',').map do |range|
  min, max = range.split('-').map(&:to_i)
  invalid_ids += invalid_ids_in_range(min, max)
end
p invalid_ids.sum
