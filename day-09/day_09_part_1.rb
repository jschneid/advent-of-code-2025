def tile_rectangle_area(x0, y0, x1, y1)
  width = (x1 - x0).abs + 1
  height = (y1 - y0).abs + 1
  width * height
end

def find_largest_rectangle(tiles)
  max_area = 0
  tiles.combination(2) do |tile_a, tile_b|
    area = tile_rectangle_area(tile_a[0], tile_a[1], tile_b[0], tile_b[1])
    max_area = area if area > max_area
  end
  max_area
end

tiles = []
File.foreach('day-09/input.txt') do |line|
  tiles << line.split(',').map(&:to_i)
end

find_largest_rectangle(tiles)
p find_largest_rectangle(tiles)
