class JunctionBox
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def distance_to(other)
    Math.sqrt((other.x - x)**2 + (other.y - y)**2 + (other.z - z)**2)
  end
end

class JunctionBoxPair
  attr_reader :a, :b

  def initialize(a, b)
    @a = a
    @b = b
  end

  def distance
    a.distance_to(b)
  end
end

def add_to_circuit(circuits, junction_box_a, junction_box_b)
  existing_circuit_a = circuits.find { |circuit| circuit.include?(junction_box_a) }
  existing_circuit_b = circuits.find { |circuit| circuit.include?(junction_box_b) }

  if existing_circuit_a && existing_circuit_b
    if existing_circuit_a != existing_circuit_b
      existing_circuit_a.merge(existing_circuit_b)
      circuits.delete(existing_circuit_b)
    end
    return
  end

  if existing_circuit_a
    existing_circuit_a << junction_box_b
    return
  end

  if existing_circuit_b
    existing_circuit_b << junction_box_a
    return
  end

  circuits << Set.new([junction_box_a, junction_box_b])
end


junction_boxes = File.readlines('day-08/input.txt').map do |line|
  x, y, z = line.split(',').map(&:to_i)
  JunctionBox.new(x, y, z)
end

junction_box_pairs = junction_boxes.combination(2)
pair_distances = {}
junction_box_pairs.each do |a, b|
  pair = JunctionBoxPair.new(a, b)
  pair_distances[pair] = pair.distance
end

circuits = []
sorted_distances = pair_distances.sort_by { |_, distance| distance }

1000.times do |i|
  junction_box_pair = sorted_distances[i][0]
  add_to_circuit(circuits, junction_box_pair.a, junction_box_pair.b)
end

p circuits.map(&:size).sort.last(3).reduce(:*)
