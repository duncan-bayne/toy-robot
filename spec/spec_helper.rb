require 'arghspec'
require 'simplecov'
SimpleCov.start

require_relative '../toy_robot/simulator.rb'

RSpec.configure do |config|
  config.formatter = Arghspec::ElectroFormatter
end
