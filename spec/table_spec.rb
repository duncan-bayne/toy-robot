require 'spec_helper'

describe 'Table' do

  let(:table) { Table.new }

  describe '#place' do

    it 'allows placement' do
      expect(table.place(0, 0)).not_to be_nil
    end

    it 'disallows placement at X co-ordinates < 0' do
      expect(table.place(-1, 0)).to be_nil
    end

    it 'disallows placement at X co-ordinates > 4' do
      expect(table.place(5, 0)).to be_nil
    end

    it 'disallows placement at Y co-ordinates < 0' do
      expect(table.place(0, -1)).to be_nil
    end

    it 'disallows placement at Y co-ordinates > 4' do
      expect(table.place(0, 5)).to be_nil
    end
  end

  describe '#placed?' do

    it 'is initially false' do
      expect(table.placed?).to be false
    end

    describe 'after a valid placement' do

      before { table.place(0, 0) }

      it 'returns true' do
        expect(table.placed?).to be true
      end
    end

    describe 'after an invalid placement' do

      before { table.place(-1, -1) }

      it 'returns false' do
        expect(table.placed?).to be false
      end
    end
  end


  describe '#position' do

    it 'is initially nil' do
      expect(table.position).to be_nil
    end

    describe 'after a valid placement' do

      before { table.place(0, 0) }

      it 'returns the co-ordinates of the placement' do
        expect(table.position).to eq(x: 0, y: 0)
      end
    end

    describe 'after an invalid placement' do

      before { table.place(-1, -1) }

      it 'remains nil after an invalid placement' do
        expect(table.position).to be_nil
      end
    end
  end
end