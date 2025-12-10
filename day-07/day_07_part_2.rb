lines = File.readlines('day-07/input.txt')
beam_timelines_at_position = {}
beam_timelines_at_position[lines[0].index('S')] = 1

lines[1..].each do |line|
  next_beam_timelines_at_position = {}
  beam_timelines_at_position.each do |position, timelines|
    if line[position] == '^'
      next_beam_timelines_at_position.key?(position - 1) ? next_beam_timelines_at_position[position - 1] += timelines : next_beam_timelines_at_position[position - 1] = timelines
      next_beam_timelines_at_position.key?(position + 1) ? next_beam_timelines_at_position[position + 1] += timelines : next_beam_timelines_at_position[position + 1] = timelines
    else
      next_beam_timelines_at_position.key?(position) ? next_beam_timelines_at_position[position] += timelines : next_beam_timelines_at_position[position] = timelines
    end
  end

  beam_timelines_at_position = next_beam_timelines_at_position
end

p beam_timelines_at_position.values.sum
