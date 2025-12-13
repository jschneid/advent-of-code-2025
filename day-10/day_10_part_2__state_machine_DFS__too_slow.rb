class Machine
  attr_reader :target_joltages, :buttons, :state, :button_pushes

  def initialize(target_joltages, buttons)
    @target_joltages = target_joltages
    @buttons = buttons
    @state = Array.new(target_joltages.length, 0)
    @button_pushes = 0
  end

  def push_button_index(button_index)
    @button_pushes += 1

    @buttons[button_index].each do |counter|
      @state[counter] += 1
    end
  end

  def any_joltage_exceeded?
    @state.each_with_index do |joltage, index|
      return true if joltage > @target_joltages[index]
    end
    false
  end

  def dup
    new_machine = Machine.new(@target_joltages, @buttons)
    new_machine.instance_variable_set(:@state, @state.dup)
    new_machine.instance_variable_set(:@button_pushes, @button_pushes)
    new_machine
  end

  def debug_state
    "joltage states: #{@state}, presses: #{@button_pushes}"
  end
end

def buttons_strings_to_ints(buttons_strings)
  buttons_strings.map do |buttons_string|
    buttons_string[0].split(',').map(&:to_i)
  end
end

def machines_from_input_file
  machines = []

  File.open("day-10/input.txt").each do |line|
    buttons_strings = line.scan(/\(([\d,]+)\)/)
    buttons = buttons_strings_to_ints(buttons_strings)

    target_joltages_string = line.match(/{(.*)}/)[1]
    target_joltages = target_joltages_string.split(',').map(&:to_i)

    machines << Machine.new(target_joltages, buttons)
  end

  machines
end

def find_fewest_button_presses(machine)
  states_presses = {}

  queue = [machine]
  until queue.empty?
    current_machine = queue.shift

    return current_machine.button_pushes if current_machine.state == current_machine.target_joltages

    pp "Exploring machine state: #{current_machine.debug_state}"

    current_machine.buttons.each_index do |button_index|
      updated_machine = current_machine.dup

      updated_machine.push_button_index(button_index)

      state_key = updated_machine.state.join(',')
      next if states_presses.key?(state_key) && states_presses[state_key] <= updated_machine.button_pushes

      next if updated_machine.any_joltage_exceeded?

      states_presses[state_key] = updated_machine.button_pushes

      queue << updated_machine
    end
  end

  raise "No solution found for machine #{machine.debug_state}"
end

machines = machines_from_input_file

total_button_presses = 0
machines.each_with_index do |machine, i|
  button_presses = find_fewest_button_presses(machine)
  p "Machine #{i} solved in #{button_presses} button presses."
  total_button_presses += button_presses
end

p total_button_presses
