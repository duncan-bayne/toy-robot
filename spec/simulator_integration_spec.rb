require 'spec_helper'

describe 'Simulator' do

  before do    
    @simulator = Simulator.new
  end

  it 'places' do
    @simulator.execute('PLACE 1,2,SOUTH')
    @simulator.execute('REPORT').should == "1,2,SOUTH"
  end

  it 'moves' do
    [ 'PLACE 0,0,NORTH', 'MOVE' ].each { |command| @simulator.execute command }
    @simulator.execute('REPORT').should == "0,1,NORTH"
  end

  it 'rotates' do
    [ 'PLACE 0,0,NORTH', 'LEFT' ].each { |command| @simulator.execute command }
    @simulator.execute('REPORT').should == '0,0,WEST'
  end

  it 'rotates and moves' do
    [ 'PLACE 1,2,EAST', 'MOVE', 'MOVE', 'LEFT', 'MOVE' ].each { |command| @simulator.execute command }
    @simulator.execute('REPORT').should == '3,3,NORTH'
  end

  it 'ignores commands before a place' do
    [ 'MOVE', 'LEFT', 'RIGHT', 'PLACE 1,1,SOUTH' ].each { |command| @simulator.execute command }
    @simulator.execute('REPORT').should == '1,1,SOUTH'
  end

  it 'ignores PLACEs that would cause the robot to fall from the table' do
    [ 'PLACE 0,0,NORTH', 'PLACE -1,0,NORTH', 'MOVE' ].each { |command| @simulator.execute command }
    @simulator.execute('REPORT').should == '0,1,NORTH'
  end

  it 'ignores MOVEs that would cause the robot to fall from the table' do
    [ 'PLACE 0,4,NORTH', 'MOVE' ].each { |command| @simulator.execute command }
    @simulator.execute('REPORT').should == '0,4,NORTH'
  end

  it 'ignores PLACEs with invalid orientations but valid co-ordinates' do
    [ 'PLACE 0,0,WOMBLES' ].each { |command| @simulator.execute command }
    @simulator.execute('REPORT').should == 'Ignoring REPORT until robot is PLACEd.'
  end

  it 'ignores PLACEs with valid orientations but invalid co-ordinates' do
    [ 'PLACE -1,-1,NORTH' ].each { |command| @simulator.execute command }
    @simulator.execute('REPORT').should == 'Ignoring REPORT until robot is PLACEd.'
  end

end

