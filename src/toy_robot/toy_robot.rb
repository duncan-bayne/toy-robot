#!/usr/bin/env ruby

require_relative 'simulator'

simulator = Simulator.new
while command = STDIN.gets
  output = simulator.execute(command)
  puts output if output
end
