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

    before do
      @data = []
      @data << OpenStruct.new(:city => 'London', :quarter => 'Q1', :sales => 100)
      @data << OpenStruct.new(:city => 'London', :quarter => 'Q2', :sales => 200)
      @data << OpenStruct.new(:city => 'London', :quarter => 'Q3', :sales => 300)
      @data << OpenStruct.new(:city => 'London', :quarter => 'Q4', :sales => 400)
      @data << OpenStruct.new(:city => 'Cape Town', :quarter => 'Q1', :sales => 5)
      @data << OpenStruct.new(:city => 'Cape Town', :quarter => 'Q1', :sales => 15)
      @data << OpenStruct.new(:city => 'Cape Town', :quarter => 'Q1', :sales => 30)
      @data << OpenStruct.new(:city => 'New York', :quarter => 'Q1', :sales => 10)
      @data << OpenStruct.new(:city => 'New York', :quarter => 'Q2', :sales => 20)
      @data << OpenStruct.new(:city => 'New York', :quarter => 'Q3', :sales => 30)
      @data << OpenStruct.new(:city => 'New York', :quarter => 'Q4', :sales => 10)
      @data << OpenStruct.new(:city => 'New York', :quarter => 'Q4', :sales => 30)
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
      it { should == ['Cape Town', 'London', 'New York'] }
    end

    context 'initializing the grid' do
      before do
        @expected_result = [
            [0, 0, 0],
            [0, 0, 0]
        ]
      end
      subject { @instance.initialize_grid 2, 3, 0 }
      it { should == @expected_result }
    end

    context 'matching data' do
      context 'single matching data item' do
        subject { @instance.matching_data 'London', 'Q1' }
        specify { subject.size.should == 1 }
        specify { subject.first.should == @data.first }
      end

      context 'multiple matching data items' do
        subject { @instance.matching_data 'Cape Town', 'Q1' }
        specify { subject.size.should == 3 }
        specify { subject[0].should == @data[4] }
        specify { subject[1].should == @data[5] }
        specify { subject[2].should == @data[6] }
      end
    end

    context 'aggregating the data in the grid' do
      before do
        @instance.initialize_grid 3, 4, 0
        @expected_result = [
            [50, 0, 0, 0],
            [100, 200, 300, 400],
            [10, 20, 30, 40]
        ]
      end
      subject { @instance.populate_grid }
      it { should == @expected_result }
    end

    context 'generate' do
      before do
        @expected_result = {
            :headers => ['', 'Q1', 'Q2', 'Q3', 'Q4', 'Total'],
            :rows    => [
                ['Cape Town', 50, 0, 0, 0, 50],
                ['London', 100, 200, 300, 400, 1000],
                ['New York', 10, 20, 30, 40, 100]
            ],
            :totals  => ['Total', 160, 220, 330, 440, 1150]
        }
      end
      subject { @instance.generate }
      it { should == @expected_result }
    end

  end
end
