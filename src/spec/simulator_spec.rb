require 'spec_helper'

describe 'Simulator' do

  before do
    @table = double('table')
    @table.stub(:place)
    Table.stub(:new).and_return(@table)

    @robot = double('robot')
    @robot.stub(:orient)
    Robot.stub(:new).and_return(@robot)

    @simulator = Simulator.new
  end

  describe '#execute' do
    
    describe 'PLACE' do
      
      describe 'at valid co-ordinates in a valid direction' do

        it 'places the robot on the table at the specified location' do
          @table.should_receive(:place).with(0, 0)
          @simulator.execute([ 'PLACE 0,0,NORTH' ])
        end

        it 'configures the robot to be facing in the specified direction' do
          @robot.should_receive(:orient).with(:north)
          @simulator.execute([ 'PLACE 0,0,NORTH' ])
        end
      end
    end
  end
end
