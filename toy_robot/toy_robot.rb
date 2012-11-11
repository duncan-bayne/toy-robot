#!/usr/bin/env ruby

require_relative 'simulator'

if ARGV.length > 0
  puts File.read(File.dirname(__FILE__) + '/../README.md')
  exit
end

simulator = Simulator.new

command = STDIN.gets
while command
  output = simulator.execute(command)
  puts output if output
  command = STDIN.gets
end
