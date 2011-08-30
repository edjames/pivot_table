require 'spec_helper'

module PivotTable
  describe Calculator do
    class TestClass
      include Calculator
    end

    before do
      @instance = TestClass.new
    end

    context 'return the sum of an array' do
      subject { @instance.array_sum [1, 2, 3, 4] }
      it { should == 10 }
    end

    context 'append totals to the rows in a grid' do
      before do
        @data = [
            [1, 3, 5],
            [2, 4, 6]
        ]

        @expected_result = [
            [1, 3, 5, 9],
            [2, 4, 6, 12]
        ]
      end
      subject { @instance.append_row_totals @data }
      it { should == @expected_result }
    end

    context 'add row of column totals to a grid' do
      before do
        @data = [
            [1, 3, 5],
            [2, 4, 6]
        ]

        @expected_result = [3, 7, 11]
      end
      subject { @instance.calculate_column_totals @data }
      it { should == @expected_result }
    end
  end
end