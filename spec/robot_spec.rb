require 'spec_helper'

describe 'Robot' do

  let(:robot) { Robot.new }

  describe '#left' do

    context 'facing north' do

      before do
        robot.orient(:north)
        robot.left
      end

      it 'faces west' do
        expect(robot.orientation).to eq(:west)
      end
    end

    context 'facing south' do

      before do
        robot.orient(:south)
        robot.left
      end

      it 'faces east' do
        expect(robot.orientation).to eq(:east)
      end
    end

    context 'facing west' do

      before do
        robot.orient(:west)
        robot.left
      end

      it 'faces south' do
        expect(robot.orientation).to eq(:south)
      end
    end

    context 'facing east' do

      before do
        robot.orient(:east)
        robot.left
      end

      it 'faces north' do
        expect(robot.orientation).to eq(:north)
      end
    end
  end

  describe '#orient' do

    it 'allows orientation to the :north' do
      expect(robot.orient(:north)).not_to be_nil
    end

    it 'allows orientation to the :south' do
      expect(robot.orient(:south)).not_to be_nil
    end

    it 'allows orientation to the :west' do
      expect(robot.orient(:west)).not_to be_nil
    end

    it 'allows orientation to the :east' do
      expect(robot.orient(:east)).not_to be_nil
    end

    it 'disallows orientation to an invalid heading' do
      expect(robot.orient(:wombles)).to be_nil
    end
  end

  describe '#orientation' do

    it 'is initially nil' do
      expect(robot.orientation).to be_nil
    end

    context 'after valid orientation' do

      before { robot.orient(:north) }

      it 'returns the orientation' do
        expect(robot.orientation).to eq(:north)
      end
    end
  end

  describe '#right' do

    context 'facing north' do

      before do
        robot.orient(:north)
        robot.right
      end

      it 'faces east' do
        expect(robot.orientation).to eq(:east)
      end
    end

    context 'facing south' do

      before do
        robot.orient(:south)
        robot.right
      end

      it 'faces west' do
        expect(robot.orientation).to eq(:west)
      end
    end

    context 'facing west' do

      before do
        robot.orient(:west)
        robot.right
      end

      it 'faces north' do
        expect(robot.orientation).to eq(:north)
      end
    end

    context 'facing east' do

      before do
        robot.orient(:east)
        robot.right
      end

      it 'faces south' do
        expect(robot.orientation).to eq(:south)
      end
    end
  end

  describe '#vector' do

    context 'facing north' do

      before { robot.orient(:north) }

      it 'moves up' do
        expect(robot.vector).to eq(x: 0, y: 1)
      end
    end

    context 'facing south' do

      before { robot.orient(:south) }

      it 'moves down' do
        expect(robot.vector).to eq(x: 0, y: -1)
      end
    end

    describe 'facing west' do

      before do
        robot.orient(:west)
      end

      it 'moves left' do
        expect(robot.vector).to eq(x: -1, y: 0)
      end
    end

    describe 'facing east' do

      before do
        robot.orient(:east)
      end

      it 'moves right' do
        expect(robot.vector).to eq(x: 1, y: 0)
      end
    end
  end
end
