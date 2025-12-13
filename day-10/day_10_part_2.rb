# Prerequisites:
# 1. brew install glpk
# 2. gem install rulp
# rulp ("Ruby Linear Programming") docs: https://github.com/wouterken/rulp

require 'rulp'

class Machine
  attr_reader :target_joltages, :buttons

  def initialize(target_joltages, buttons)
    @target_joltages = target_joltages
    @buttons = buttons
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
  # Work around a bizarre issue where programmatically mass-creating Rulp variables according to the docs
  # in https://github.com/wouterken/rulp?tab=readme-ov-file#variables
  # results in a wrong solution for the specific input "[#.#.] (0) (1,2,3) (0,2) (1,2) {20,15,29,1}".
  #
  # If the library was working as (apparently) intended, we'd just be able to do this instead:
  # buttons = (0..machine.buttons.count - 1).map do |button_index|
  #   Buttons_i(button_index) >= 0
  # end
  buttons = []
  if (machine.buttons.count >= 1)
    buttons << (ButtonA_i >= 0)
  end
  if (machine.buttons.count >= 2)
    buttons << (ButtonB_i >= 0)
  end
  if (machine.buttons.count >= 3)
    buttons << (ButtonC_i >= 0)
  end
  if (machine.buttons.count >= 4)
    buttons << (ButtonD_i >= 0)
  end
  if (machine.buttons.count >= 5)
    buttons << (ButtonE_i >= 0)
  end
  if (machine.buttons.count >= 6)
    buttons << (ButtonF_i >= 0)
  end
  if (machine.buttons.count >= 7)
    buttons << (ButtonG_i >= 0)
  end
  if (machine.buttons.count >= 8)
    buttons << (ButtonH_i >= 0)
  end
  if (machine.buttons.count >= 9)
    buttons << (ButtonI_i >= 0)
  end
  if (machine.buttons.count >= 10)
    buttons << (ButtonJ_i >= 0)
  end
  if (machine.buttons.count >= 11)
    buttons << (ButtonK_i >= 0)
  end
  if (machine.buttons.count >= 12)
    buttons << (ButtonL_i >= 0)
  end
  if (machine.buttons.count >= 13)
    buttons << (ButtonM_i >= 0)
  end
  if (machine.buttons.count >= 14)
    buttons << (ButtonN_i >= 0)
  end
  if (machine.buttons.count >= 15)
    buttons << (ButtonO_i >= 0)
  end
  if (machine.buttons.count >= 16)
    buttons << (ButtonP_i >= 0)
  end

  buttons_map = {}
  machine.buttons.each_with_index do |button, index|
    buttons_map[button] = buttons[index]
  end

  constraints = []
  machine.target_joltages.each_with_index do |target_joltage, index|
    constraints << (machine.buttons.select { |button| button.include? index }.map { |button| buttons_map[button] }.inject(:+) == target_joltage)
  end

  problem = Rulp::Min(buttons.inject(:+)) [constraints]

  raise "Could not find solution for #{machine}" unless problem.glpk

  buttons.map(&:value).sum
end

machines = machines_from_input_file

total_button_presses = 0
machines.each_with_index do |machine, i|
  button_presses = find_fewest_button_presses(machine)
  p "Machine #{i} solved in #{button_presses} button presses."
  total_button_presses += button_presses
end

p total_button_presses
