#!/usr/bin/env ruby

require_relative 'simulator'

simulator = Simulator.new

command = STDIN.gets
while command
  output = simulator.execute(command)
  puts output if output
  command = STDIN.gets
end
