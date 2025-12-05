dial = 50
zeroes = 0

File.foreach('day-01/input.txt') do |line|
  delta = line[1..].to_i
  delta *= -1 if line[0] == 'L'
  dial = (dial + delta) % 100
  zeroes += 1 if dial.zero?
end

p zeroes
