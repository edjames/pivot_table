require 'spec_helper'

module Pivot
  describe Table do
    context 'accessors' do
      subject { Table.new }
      it { should respond_to :data }
      it { should respond_to :column }
      it { should respond_to :row }
      it { should respond_to :pivot_on }
    end

    context 'instantiate using explicit block form' do
      subject do
        Table.new do |i|
          i.data     = :data
          i.column   = :column
          i.row      = :row
          i.pivot_on = :pivot_on
        end
      end

      specify { subject.data.should == :data }
      specify { subject.column.should == :column }
      specify { subject.row.should == :row }
      specify { subject.pivot_on.should == :pivot_on }
    end

    before(:all) do
      @data = []
      @data << OpenStruct.new(:city => 'London', :quarter => 'Q1', :sales => 100)
      @data << OpenStruct.new(:city => 'London', :quarter => 'Q2', :sales => 200)
      @data << OpenStruct.new(:city => 'London', :quarter => 'Q3', :sales => 300)
      @data << OpenStruct.new(:city => 'London', :quarter => 'Q4', :sales => 400)
      @data << OpenStruct.new(:city => 'New York', :quarter => 'Q1', :sales => 10)
      @data << OpenStruct.new(:city => 'New York', :quarter => 'Q2', :sales => 20)
      @data << OpenStruct.new(:city => 'New York', :quarter => 'Q3', :sales => 30)
      @data << OpenStruct.new(:city => 'New York', :quarter => 'Q4', :sales => 40)
      @instance = Table.new do |i|
        i.data     = @data
        i.column   = :quarter
        i.row      = :city
        i.pivot_on = :sales
      end
    end

    subject { @instance }

    context 'column headers' do
      subject { @instance.column_headers }
      it { should == ['Q1', 'Q2', 'Q3', 'Q4'] }
    end

    context 'row headers' do
      subject { @instance.row_headers }
      it { should == ['London', 'New York'] }
    end

    context 'pivoted row data' do
      subject { @instance.pivoted_row_data }
      it { should == [['London', 100, 200, 300, 400], ['New York', 10, 20, 30, 40]] }
    end

    context 'row totals' do
      subject { @instance.insert_row_totals [[1, 2, 3], [10, 20, 30]] }
      it { should == [[1, 2, 3, 6], [10, 20, 30, 60]] }
    end

    context 'sum for row' do
      subject { @instance.row_sum [1, 2, 3, 4, 5] }
      it { should == 15 }
    end

    context 'column totals' do
      subject { @instance.column_totals [[1, 2, 3], [4, 5, 6]] }
      it { should == [5, 7, 9] }
    end

    context 'generate' do
      before do
        @expected_result = {
            :headers => ['', 'Q1', 'Q2', 'Q3', 'Q4', 'Total'],
            :rows    => [
                ['London', 100, 200, 300, 400, 1000],
                ['New York', 10, 20, 30, 40, 100]
            ],
            :totals  => ['Total', 110, 220, 330, 440, 1100]
        }
      end
      subject { @instance.generate }
      it { should == @expected_result }
    end

  end
end