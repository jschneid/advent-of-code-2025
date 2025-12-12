class Machine
  attr_reader :target_state, :buttons, :state, :button_pushes, :buttons_left

  def initialize(target_state, buttons, state_length)
    @target_state = target_state
    @buttons = buttons
    @state_length = state_length
    @state = 0
    @button_pushes = 0
    @buttons_left = (0..buttons.length - 1).to_a
  end

  def push_button_index(button_index)
    @button_pushes += 1
    @buttons_left.delete(button_index)
    @state ^= @buttons[button_index]
  end

  def dup
    new_machine = Machine.new(@target_state, @buttons, @state_length)
    new_machine.instance_variable_set(:@state, @state)
    new_machine.instance_variable_set(:@button_pushes, @button_pushes)
    new_machine.instance_variable_set(:@buttons_left, @buttons_left.dup)
    new_machine
  end

  def debug_state
    "[#{@state.to_s(2).reverse.gsub('0', '.').gsub('1', '#').ljust(@state_length, '.')}] (#{@state}), presses: #{@button_pushes}, buttons left: #{@buttons_left}"
  end
end

def target_state_string_to_int(target_state_string)
  target_state_string.reverse.gsub('#', '1').gsub('.', '0').to_i(2)
end

def buttons_strings_to_int(buttons_strings)
  buttons_strings.map do |buttons_string|
    buttons_string[0].split(',').map(&:to_i).map { |i| 2**i }.sum
  end
end

def machines_from_input_file
  machines = []

  File.open("day-10/input.txt").each do |line|
    target_state_string = line.match(/\[(.*)\]/)[1]
    target_state = target_state_string_to_int(target_state_string)

    buttons_strings = line.scan(/\(([\d,]+)\)/)
    buttons = buttons_strings_to_int(buttons_strings)

    machines << Machine.new(target_state, buttons, target_state_string.length)
  end

  machines
end

def find_fewest_button_presses(machine)
  queue = [machine]
  until queue.empty?
    current_machine = queue.shift

    return current_machine.button_pushes if current_machine.state == current_machine.target_state

    current_machine.buttons_left.each do |button_index|
      updated_machine = current_machine.dup

      updated_machine.push_button_index(button_index)

      queue << updated_machine
    end
  end
end

machines = machines_from_input_file

total_button_presses = 0
machines.each_with_index do |machine, i|
  button_presses = find_fewest_button_presses(machine)
  p "Machine #{i} solved in #{button_presses} button presses."
  total_button_presses += button_presses
end

p total_button_presses
