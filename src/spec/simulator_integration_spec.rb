require 'spec_helper'

describe 'Simulator' do

  before do    
    @simulator = Simulator.new
  end

  it 'places' do
    commands = [
                'PLACE 1,2,SOUTH',
                'REPORT'
               ]
    @simulator.execute(commands).should == "1,2,SOUTH\n"
  end

  it 'moves' do
    commands = [
                'PLACE 0,0,NORTH',
                'MOVE',
                'REPORT'
               ]
    @simulator.execute(commands).should == "0,1,NORTH\n"
  end

  it 'rotates' do
    commands = [
                'PLACE 0,0,NORTH',
                'LEFT',
                'REPORT'
               ]

    @simulator.execute(commands).should == "0,0,WEST\n"
  end

  it 'rotates and moves' do
    commands = [
                'PLACE 1,2,EAST', 
                'MOVE',
                'MOVE',
                'LEFT', 
                'MOVE',
                'REPORT',
               ]

    @simulator.execute(commands).should == "3,3,NORTH\n"
  end

  it 'reports multiple times' do
    commands = [
                'PLACE 1,2,SOUTH',
                'REPORT',
                'REPORT'
               ]

    @simulator.execute(commands).should == "1,2,SOUTH\n1,2,SOUTH\n"

  end
end

