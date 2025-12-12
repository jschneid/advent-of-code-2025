def debug_print_tiles(tiles_colors)
  tile_positions = tiles_colors.keys

  min_x = tile_positions.map { |pos| pos[0] }.min
  max_x = tile_positions.map { |pos| pos[0] }.max
  min_y = tile_positions.map { |pos| pos[1] }.min
  max_y = tile_positions.map { |pos| pos[1] }.max

  (min_y..max_y).each do |y|
    row = ''
    (min_x..max_x).each do |x|
      color = tiles_colors[[x, y]]
      row += case color
             when :red
               'R'
             when :green
               'G'
             when :black
               'B'
             else
               '.'
             end
    end
    puts row
  end
end

def debug_print_area_around_tile(tiles_colors, x, y)
  min_x = x - 5
  max_x = x + 5
  min_y = y - 5
  max_y = y + 5

  (min_y..max_y).each do |y|
    row = ''
    (min_x..max_x).each do |x|
      color = tiles_colors[[x, y]]
      row += case color
             when :red
               'R'
             when :green
               'G'
             when :black
               'B'
             else
               '.'
             end
    end
    puts row
  end
end
