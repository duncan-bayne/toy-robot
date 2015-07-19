require 'spec_helper'

describe 'Simulator' do
  let(:robot) { double('robot') }
  let(:simulator) { Simulator.new }
  let(:table) { double('table') }

  before do
    allow(table).to receive(:place)
    allow(Table).to receive(:new).and_return(table)

    allow(robot).to receive(:orient)
    allow(Robot).to receive(:new).and_return(robot)
  end

  describe '#execute' do

    describe 'empty string' do

      it 'completely ignores the command without warning the user' do
        expect(simulator.execute('')).to be_nil
      end
    end

    describe 'whitespace' do

      it 'completely ignores the command without warning the user' do
        expect(simulator.execute('              ')).to be_nil
      end
    end

    describe 'before the robot has been placed' do

      before { allow(table).to receive(:placed?).and_return(false) }

      describe 'LEFT' do

        before { expect(robot).not_to receive(:left) }

        it 'warns the user but does nothing else' do
          expect(simulator.execute('LEFT')).to eq('Ignoring LEFT until robot is PLACEd.')
        end
      end

      describe 'MOVE' do

        before do
          expect(robot).not_to receive(:vector)
          expect(table).not_to receive(:position)
          expect(table).not_to receive(:place)
        end

        it 'warns the user but does nothing else' do
          expect(simulator.execute('MOVE')).to eq('Ignoring MOVE until robot is PLACEd.')
        end
      end

      describe 'PLACE' do

        describe 'at valid co-ordinates in a valid direction' do

          before do
            expect(robot).to receive(:orient).with(:north).and_return(:north)
            expect(table).to receive(:place).with(0, 0)
          end

          it 'places the robot on the table at the specified location and orients it' do
            simulator.execute('PLACE 0,0,NORTH')
          end
        end

        describe 'at valid co-ordinates in an invalid direction' do

          before do
            expect(robot).to receive(:orient).with(:wombles).and_return(nil)
            expect(table).not_to receive(:place)
          end

          it 'does not place the robot on the table' do
            expect(simulator.execute('PLACE 0,0,WOMBLES')).to eq('Ignoring PLACE with invalid arguments.')
          end
        end
      end

      describe 'REPORT' do

        before do
          expect(table).not_to receive(:position)
          expect(robot).not_to receive(:orientation)
        end

        it 'warns the user but does nothing else' do
          expect(simulator.execute('REPORT')).to eq('Ignoring REPORT until robot is PLACEd.')
        end
      end

      describe 'RIGHT' do

        before { expect(robot).not_to receive(:right) }

        it 'warns the user but does nothing else' do
          expect(simulator.execute('RIGHT')).to eq('Ignoring RIGHT until robot is PLACEd.')
        end
      end
    end

    describe 'after the robot has been placed' do

      before { allow(table).to receive(:placed?).and_return(true) }

      describe 'LEFT' do

        before { expect(robot).to receive(:left) }

        it 'instructs the robot to turn left' do
          simulator.execute('LEFT')
        end
      end

      describe 'MOVE' do

        describe 'to a valid place on the table' do

          before do
            expect(robot).to receive(:vector).and_return({ x: 1, y: 1 })
            expect(table).to receive(:position).and_return({ x: 1, y: 1 })
            expect(table).to receive(:place).with(2, 2)
          end

          it 'retrieves a movement vector from the robot and applies it to the table' do
            simulator.execute('MOVE')
          end
        end

        describe 'off the table' do

          before do
            expect(robot).to receive(:vector).and_return({ x: 1, y: 1 })
            expect(table).to receive(:position).and_return({ x: 4, y: 4 })
            expect(table).to receive(:place).with(5, 5).and_return(nil)
          end

          it 'warns the user and does not move the robot off the table' do
            expect(simulator.execute('MOVE')).to eq('Ignoring MOVE off the table.')
          end

        end
      end

      describe 'PLACE' do

        describe 'at valid co-ordinates in a valid direction' do

          before do
            expect(robot).to receive(:orient).with(:north).and_return(:north)
            expect(table).to receive(:place).with(0, 0)
          end

          it 'places the robot on the table at the specified location and orients it' do
            simulator.execute('PLACE 0,0,NORTH')
          end
        end

        describe 'with invalid arguments' do

          before { expect(table).not_to receive(:place) }

          it 'warns the user and does not place the robot on the table' do
            expect(simulator.execute('PLACE SOME WOMBLES')).to eq('Ignoring PLACE with invalid arguments.')
          end
        end
      end

      describe 'REPORT' do

        before do
          expect(table).to receive(:position).and_return({ x: 1, y: 2 })
          expect(robot).to receive(:orientation).and_return(:south)
        end

        it 'returns the result in specified format' do
          expect(simulator.execute('REPORT')).to eq('1,2,SOUTH')
        end
      end

      describe 'RIGHT' do

        before { expect(robot).to receive(:right) }

        it 'instructs the robot to turn right' do
          simulator.execute('RIGHT')
        end
      end
    end
  end
end
