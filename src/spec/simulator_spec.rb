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

    describe 'LEFT' do

      it 'instructs the robot to turn left' do
        @robot.should_receive(:left)
        
        @simulator.execute([ 'LEFT' ])
      end

    end

    describe 'MOVE' do

      it 'retrieves a movement vector from the robot and applies it to the board' do
        @robot.should_receive(:vector).and_return({ x: 1, y: 1 })
        @table.should_receive(:position).and_return({ x: 1, y: 1 })
        @table.should_receive(:place).with(2, 2)

        @simulator.execute([ 'MOVE' ])
      end

      it 'applies the movement vector to the location on the board' do
      end

    end

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

    describe 'REPORT' do

      it 'returns the result in specified format' do
        @table.should_receive(:position).and_return({ x: 1, y: 2 })
        @robot.should_receive(:orientation).and_return(:south)
        @simulator.execute([ 'REPORT' ]).should == "1,2,SOUTH\n"
      end

    end
    
    describe 'RIGHT' do

      it 'instructs the robot to turn right' do
        @robot.should_receive(:right)
        
        @simulator.execute([ 'RIGHT' ])
      end

    end
  end
end
