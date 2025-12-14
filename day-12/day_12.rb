# So, evidently this is a troll puzzle: All the instructions and input data about
# different sizes of present shapes can be ignored, and all presents can instead just
# be treated as 3x3 squares? I admittedly don't get the humor. But then again, I also
# don't really get why "Rickrolling" or "BeanBoozled" are funny, either, so ¯\_(ツ)_/¯

regions_that_can_fit_all_shapes = 0
File.foreach('day-12/input.txt') do |line|
  next unless line.include?('x')
  region_x_size, region_y_size = line.split[0].split('x').map(&:to_i)
  total_shapes_count = line.split[1..].map(&:to_i).sum
  regions_that_can_fit_all_shapes += 1 if (region_x_size / 3) * (region_y_size / 3) >= total_shapes_count
end
puts regions_that_can_fit_all_shapes


