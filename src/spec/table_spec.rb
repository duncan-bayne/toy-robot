require 'spec_helper'

describe 'Table' do

  before do
    @table = Table.new
  end

  describe '#place' do

    it 'allows placement' do
      @table.place(0, 0).should_not == nil
    end

    it 'disallows placement at X co-ordinates < 0' do
      @table.place(-1, 0).should == nil
    end

    it 'disallows placement at X co-ordinates > 4' do
      @table.place(5, 0).should == nil
    end

    it 'disallows placement at Y co-ordinates < 0' do
      @table.place(0, -1).should == nil
    end

    it 'disallows placement at Y co-ordinates > 4' do
      @table.place(0, 5).should == nil
    end

  end

  describe '#placed?' do

    it 'is initially false' do
      @table.placed?.should == false
    end

    describe 'after a valid placement' do

      before do
        @table.place(0, 0)
      end

      it 'returns true' do
        @table.placed?.should == true
      end

    end

    describe 'after an invalid placement' do

      before do
        @table.place(-1, -1)
      end

      it 'returns false' do
        @table.placed?.should == false
      end

    end
  end
  

  describe '#position' do

    it 'is initially nil' do
      @table.position.should == nil
    end

    describe 'after a valid placement' do

      before do
        @table.place(0, 0)
      end

      it 'returns the co-ordinates of the placement' do
        @table.position.should == { x: 0, y: 0 }
      end

    end

    describe 'after an invalid placement' do

      before do
        @table.place(-1, -1)
      end

      it 'remains nil after an invalid placement' do
        @table.position.should == nil
      end

    end

  end
end
