def add_green_tiles_between_consecutive_red_tiles(red_tiles, tiles_colors)
  red_tiles.each_cons(2) do |red_tile_a, red_tile_b|
    color_tiles_green_between(red_tile_a, red_tile_b, tiles_colors)
  end

  color_tiles_green_between(red_tiles[-1], red_tiles[0], tiles_colors)
end

def color_tiles_green_between(red_tile_a, red_tile_b, tiles_colors)
  if red_tile_a[1] == red_tile_b[1]
    y = red_tile_a[1]
    x_start = [red_tile_a[0], red_tile_b[0]].min + 1
    x_end = [red_tile_a[0], red_tile_b[0]].max - 1
    (x_start..x_end).each do |x|
      tiles_colors[[x, y]] = :green
    end
  elsif red_tile_a[0] == red_tile_b[0]
    x = red_tile_a[0]
    y_start = [red_tile_a[1], red_tile_b[1]].min + 1
    y_end = [red_tile_a[1], red_tile_b[1]].max - 1
    (y_start..y_end).each do |y|
      tiles_colors[[x, y]] = :green
    end
  end
end

def on_shape_edge?(x, y, tiles_colors)
  return true if tiles_colors[[x, y]] == :green
  return true if tiles_colors[[x, y]] == :red

  false
end

# My first idea was to flood fill the interior with green tiles (like the
# problem description says is the actual layout), but the runtime was too
# long. Instead, we'll outline the shape in black. Later when we evaluate
# red-corner rectangles, we'll be able to tell that a rectangle is out of
# bounds if any of its edges are black tiles.
def outline_shape_in_black(tiles_colors, red_tiles)
  # Fire a ray in from the left edge to find a starting point along the shape edge
  tile_y_values = red_tiles.map { |tile| tile[1] }
  mid_y = (tile_y_values.min + tile_y_values.max) / 2
  x = 0
  x += 1 until (tiles_colors.key?([x, mid_y]))

  # From this point, draw a black outline around the shape in a clockwise direction
  start_x = x
  start_y = mid_y
  y = start_y
  pen_direction = :up
  loop do
    case pen_direction
    when :up
      if on_shape_edge?(x, y - 1, tiles_colors)
        tiles_colors[[x - 1, y]] = :black
        y -= 1
      else
        if on_shape_edge?(x - 1, y, tiles_colors)
          x -= 1
          pen_direction = :left
        else
          tiles_colors[[x - 1, y]] = :black
          pen_direction = :right
        end
      end
    when :down
      if on_shape_edge?(x, y + 1, tiles_colors)
        tiles_colors[[x + 1, y]] = :black
        y += 1
      else
        if on_shape_edge?(x + 1, y, tiles_colors)
          x += 1
          pen_direction = :right
        else
          tiles_colors[[x + 1, y]] = :black
          pen_direction = :left
        end
      end
    when :right
      if on_shape_edge?(x + 1, y, tiles_colors)
        tiles_colors[[x, y - 1]] = :black
        x += 1
      else
        if on_shape_edge?(x, y - 1, tiles_colors)
          y -= 1
          pen_direction = :up
        else
          tiles_colors[[x, y - 1]] = :black
          pen_direction = :down
        end
      end
    else # :left
      if on_shape_edge?(x - 1, y, tiles_colors)
        tiles_colors[[x, y + 1]] = :black
        x -= 1
      else
        if on_shape_edge?(x, y + 1, tiles_colors)
          y += 1
          pen_direction = :down
        else
          tiles_colors[[x, y + 1]] = :black
          pen_direction = :up
        end
      end
    end

    break if x == start_x && y == start_y
  end
end

def color_remaining_tiles (tiles_colors, red_tiles)
  add_green_tiles_between_consecutive_red_tiles(red_tiles, tiles_colors)
  outline_shape_in_black(tiles_colors, red_tiles)
end

def rectangle_in_shape?(x0, y0, x1, y1, tiles_colors)
  x_start = [x0, x1].min
  x_end = [x0, x1].max
  y_start = [y0, y1].min
  y_end = [y0, y1].max

  # Top and bottom edges
  (x_start..x_end).each do |x|
    return false if tiles_colors[[x, y_start]] == :black
    return false if tiles_colors[[x, y_end]] == :black
  end

  # Left and right edges
  (y_start..y_end).each do |y|
    return false if tiles_colors[[x_start, y]] == :black
    return false if tiles_colors[[x_end, y]] == :black
  end

  true
end

def tile_rectangle_area(x0, y0, x1, y1)
  width = (x1 - x0).abs + 1
  height = (y1 - y0).abs + 1
  width * height
end

def find_largest_rectangle(red_tiles, tiles_colors)
  max_area = 0
  red_tiles.combination(2) do |tile_a, tile_b|
    area = tile_rectangle_area(tile_a[0], tile_a[1], tile_b[0], tile_b[1])
    next if area <= max_area

    next unless rectangle_in_shape?(tile_a[0], tile_a[1], tile_b[0], tile_b[1], tiles_colors)

    max_area = area
  end
  max_area
end

tiles_colors = {}
red_tiles = []
File.foreach('day-09/input.txt') do |line|
  position = line.split(',').map(&:to_i)
  tiles_colors[position] = :red
  red_tiles << position
end

color_remaining_tiles(tiles_colors, red_tiles)

p find_largest_rectangle(red_tiles, tiles_colors)
