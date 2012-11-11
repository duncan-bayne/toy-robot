require 'spec_helper'

describe 'Robot' do

  before do
    @robot = Robot.new
  end

  describe '#left' do

    describe 'facing north' do
      
      before do
        @robot.orient(:north)
        @robot.left
      end

      it 'faces west' do
        @robot.orientation.should == :west
      end

    end

    describe 'facing south' do

      before do
        @robot.orient(:south)
        @robot.left
      end

      it 'faces east' do
        @robot.orientation.should == :east
      end

    end

    describe 'facing west' do

      before do
        @robot.orient(:west)
        @robot.left
      end

      it 'faces south' do
        @robot.orientation.should == :south
      end

    end

    describe 'facing east' do

      before do
        @robot.orient(:east)
        @robot.left
      end

      it 'faces north' do
        @robot.orientation.should == :north
      end

    end

  end

  describe '#orient' do

    it 'allows orientation to the :north' do
      @robot.orient(:north).should_not == nil
    end
    
    it 'allows orientation to the :south' do
      @robot.orient(:south).should_not == nil
    end

    it 'allows orientation to the :west' do
      @robot.orient(:west).should_not == nil
    end

    it 'allows orientation to the :east' do
      @robot.orient(:east).should_not == nil
    end

    it 'disallows orientation to an invalid heading' do
      @robot.orient(:wombles).should == nil
    end

  end

  describe '#orientation' do

    it 'is initially nil' do
      @robot.orientation.should == nil
    end

    describe 'after valid orientation' do

      before do
        @robot.orient(:north)
      end

      it 'returns the orientation' do
        @robot.orientation.should == :north
      end

    end
  end

  describe '#right' do

    describe 'facing north' do
      
      before do
        @robot.orient(:north)
        @robot.right
      end

      it 'faces east' do
        @robot.orientation.should == :east
      end

    end

    describe 'facing south' do

      before do
        @robot.orient(:south)
        @robot.right
      end

      it 'faces west' do
        @robot.orientation.should == :west
      end

    end

    describe 'facing west' do

      before do
        @robot.orient(:west)
        @robot.right
      end

      it 'faces north' do
        @robot.orientation.should == :north
      end

    end

    describe 'facing east' do

      before do
        @robot.orient(:east)
        @robot.right
      end

      it 'faces south' do
        @robot.orientation.should == :south
      end

    end

  end

  describe '#vector' do

    describe 'facing north' do
      
      before do
        @robot.orient(:north)
      end

      it 'moves up' do
        @robot.vector.should == { x: 0, y: 1 }
      end

    end

    describe 'facing south' do

      before do
        @robot.orient(:south)
      end

      it 'moves down' do
        @robot.vector.should == { x: 0, y: -1 }
      end

    end

    describe 'facing west' do

      before do
        @robot.orient(:west)
      end

      it 'moves left' do
        @robot.vector.should == { x: -1, y: 0 }
      end

    end

    describe 'facing east' do

      before do
        @robot.orient(:east)
      end

      it 'moves right' do
        @robot.vector.should == { x: 1, y: 0 }
      end

    end
  end
end
