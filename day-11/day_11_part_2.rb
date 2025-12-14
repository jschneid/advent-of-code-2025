class State
  attr_reader :device, :dac_visited, :fft_visited

  def initialize(device, dac_visited, fft_visited)
    @device = device
    @dac_visited = dac_visited
    @fft_visited = fft_visited
  end

  def eql?(other)
    self.device == other.device && self.dac_visited == other.dac_visited && self.fft_visited == other.fft_visited
  end

  def hash
    [@device, @dac_visited, @fft_visited].hash
  end
end

def paths_to_out_from_device(device, devices, dac_visited, fft_visited, already_computed_states)
  if device == 'out'
    if dac_visited && fft_visited
      return 1
    else
      return 0
    end
  end

  dac_visited ||= device == 'dac'
  fft_visited ||= device == 'fft'

  total_paths = 0
  devices[device].each do |output_device|
    output_device_state = State.new(output_device, dac_visited, fft_visited)
    if already_computed_states.key?(output_device_state)
      total_paths += already_computed_states[output_device_state]
    else
      total_paths += paths_to_out_from_device(output_device, devices, dac_visited, fft_visited, already_computed_states)
    end
  end

  already_computed_states[State.new(device, dac_visited, fft_visited)] = total_paths
  total_paths
end

devices = {}
File.foreach('day-11/input.txt') do |line|
  device = line.split(':')[0]
  device_outputs = line.split(':')[1].split
  devices[device] = device_outputs
end

pp paths_to_out_from_device('svr', devices, false, false, {})
