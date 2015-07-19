require 'spec_helper'

describe 'Simulator' do
  let!(:simulator) { Simulator.new }

  subject do
    commands.each { |command| simulator.execute(command) }
    simulator.execute('REPORT')
  end

  describe 'placing' do
    let(:commands) { ['PLACE 1,2,SOUTH'] }
    it { is_expected.to eq '1,2,SOUTH' }
  end

  describe 'moving' do
    let(:commands) { ['PLACE 0,0,NORTH', 'MOVE'] }
    it { is_expected.to eq '0,1,NORTH' }
  end

  describe 'rotating' do
    let(:commands) { ['PLACE 0,0,NORTH', 'LEFT'] }
    it { is_expected.to eq '0,0,WEST' }
  end

  describe 'rotating and moving' do
    let(:commands) { ['PLACE 1,2,EAST', 'MOVE', 'MOVE', 'LEFT', 'MOVE'] }
    it { is_expected.to eq '3,3,NORTH' }
  end

  describe 'commands before a PLACE' do
    let(:commands) { ['MOVE', 'LEFT', 'RIGHT', 'PLACE 1,1,SOUTH'] }

    it 'ignores the commands' do
      expect(subject).to eq('1,1,SOUTH')
    end
  end

  describe 'PLACE that would cause the robot to fall from the table' do
    let(:commands) { ['PLACE 0,0,NORTH', 'PLACE -1,0,NORTH', 'MOVE'] }

    it 'ignores the PLACE' do
      expect(subject).to eq('0,1,NORTH')
    end
  end

  describe 'MOVE that would cause the robot to fall from the table' do
    let(:commands) { ['PLACE 0,4,NORTH', 'MOVE'] }

    it 'ignores the MOVE' do
      expect(subject).to eq('0,4,NORTH')
    end
  end

  describe 'PLACE with invalid orientations but valid co-ordinates' do
    let(:commands) { ['PLACE 0,0,WOMBLES'] }

    it 'ignores the PLACE' do
      expect(subject).to eq('Ignoring REPORT until robot is PLACEd.')
    end
  end

  describe 'PLACE with valid orientations but invalid co-ordinates' do
    let(:commands) { ['PLACE -1,-1,NORTH'] }

    it 'ignores the PLACE' do
      expect(subject).to eq('Ignoring REPORT until robot is PLACEd.')
    end
  end

  describe 'succesive valid PLACEs' do
    let(:commands) { ['PLACE -1,-1,NORTH', 'PLACE 0,0,SOUTH'] }

    it 'applies each PLACE' do
      expect(subject).to eq('0,0,SOUTH')
    end
  end
end
