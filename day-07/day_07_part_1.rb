lines = File.readlines('day-07/input.txt')
beam_positions = Set.new
beam_positions << lines[0].index('S')

beam_splits = 0
lines[1..].each do |line|
  next_beam_positions = Set.new
  beam_positions.each do |beam_position|
    if line[beam_position] == '^'
      next_beam_positions << beam_position - 1
      next_beam_positions << beam_position + 1
      beam_splits += 1
    else
      next_beam_positions << beam_position
    end
  end

  beam_positions = next_beam_positions
end

p beam_splits
