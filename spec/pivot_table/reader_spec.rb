require 'spec_helper'

module PivotTable
  describe Reader do
    class TestClass
      include Reader
    end

    before do
      @data     = [
          OpenStruct.new(:row => 'Zero', :column => 'A', :values => 1),
          OpenStruct.new(:row => 'Zero', :column => 'B', :values => 2),
          OpenStruct.new(:row => 'One', :column => 'C', :values => 3),
          OpenStruct.new(:row => 'One', :column => 'C', :values => 4),
          OpenStruct.new(:row => 'Two', :column => 'D', :values => 5),
          OpenStruct.new(:row => 'Two', :column => 'E', :values => 6)
      ]
      @instance = TestClass.new
    end

    context 'reading headers from collection' do
      subject { @instance.uniq_values @data, :row }
      it { should == %w(One Two Zero) }
    end

    context 'filtering data' do
      context 'non found' do
        subject { @instance.filter @data, :row, 'Zero', :column, 'C' }
        it { should == [] }
      end

      context 'matches found' do
        subject { @instance.filter @data, :row, 'One', :column, 'C' }
        it { should == [@data[2], @data[3]] }
      end
    end

  end
end