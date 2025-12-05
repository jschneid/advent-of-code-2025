dial = 50
zero_passes = 0

File.foreach('day-01/input.txt') do |line|
  delta = line[1..].to_i
  delta *= -1 if line[0] == 'L'

  # Correct for turning left from zero already having been counted
  zero_passes -= 1 if dial.zero? && delta.negative?

  zero_passes += ((dial + delta) / 100).abs
  dial = (dial + delta) % 100

  # Correct for landing on zero via a left turn not having been counted.
  zero_passes += 1 if dial.zero? && delta.negative?
end

p zero_passes
