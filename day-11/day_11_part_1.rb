def paths_to_out_from_device(device, devices)
  return 1 if device == 'out'

  total_paths = 0
  devices[device].each do |output_device|
    total_paths += paths_to_out_from_device(output_device, devices)
  end
  total_paths
end

devices = {}
File.foreach('day-11/input.txt') do |line|
  device = line.split(':')[0]
  device_outputs = line.split(':')[1].split
  devices[device] = device_outputs
end

pp paths_to_out_from_device('you', devices)
