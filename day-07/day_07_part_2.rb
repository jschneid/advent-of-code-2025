def add_timelines(beam_timelines_at_position, position, existing_timelines_count)
  beam_timelines_at_position[position] = beam_timelines_at_position.fetch(position, 0) + existing_timelines_count
end

lines = File.readlines('day-07/input.txt')

beam_timelines_at_position = {}
start_position = lines[0].index('S')
beam_timelines_at_position[start_position] = 1

lines[1..].each do |line|
  next_beam_timelines_at_position = {}

  beam_timelines_at_position.each do |position, timelines_count|
    if line[position] == '^'
      add_timelines(next_beam_timelines_at_position, position - 1, timelines_count)
      add_timelines(next_beam_timelines_at_position, position + 1, timelines_count)
    else
      add_timelines(next_beam_timelines_at_position, position, timelines_count)
    end
  end

  beam_timelines_at_position = next_beam_timelines_at_position
end

p beam_timelines_at_position.values.sum
