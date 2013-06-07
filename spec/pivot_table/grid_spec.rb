require 'spec_helper'

module PivotTable
  describe Grid do
    def build_object(id, row, column)
      OpenStruct.new id: id, row_name: row, column_name: column
    end

    let(:d1) { build_object(1, 'r1', 'c1') }
    let(:d2) { build_object(2, 'r1', 'c2') }
    let(:d3) { build_object(3, 'r1', 'c3') }
    let(:d4) { build_object(4, 'r2', 'c1') }
    let(:d5) { build_object(5, 'r2', 'c2') }
    let(:d6) { build_object(6, 'r2', 'c3') }

    let(:data) { [d1, d2, d3, d4, d5, d6] }

    let(:column_headers) { %w(c1 c2 c3) }
    let(:row_headers) { %w(r1 r2) }
    let(:row_0) { [d1, d2, d3] }
    let(:row_1) { [d4, d5, d6] }
    let(:column_0) { [d1, d4] }
    let(:column_1) { [d2, d5] }
    let(:column_2) { [d3, d6] }
    let(:column_totals) { [d1.id + d4.id, d2.id + d5.id, d3.id + d6.id] }
    let(:row_totals) { [d1.id + d2.id + d3.id, d4.id + d5.id + d6.id] }
    let(:grand_total) { d1.id + d2.id + d3.id + d4.id + d5.id + d6.id }

    let(:instance) do
      Grid.new do |g|
        g.source_data = data
        g.row_name    = :row_name
        g.column_name = :column_name
        g.value_name  = :id
      end
    end

    context 'accessors' do
      subject { Grid.new }
      it { should respond_to :source_data }
      it { should respond_to :row_name }
      it { should respond_to :column_name }
      it { should respond_to :columns }
      it { should respond_to :rows }
      it { should respond_to :grand_total }
    end

    describe 'build' do
      subject { instance.build }
      its(:class) { should == Grid }
    end

    describe 'columns' do
      let(:build_result) { instance.build }
      specify { build_result.columns.length.should == 3 }

      context 'column headers' do
        subject { build_result.column_headers }
        it { should == column_headers }
      end

      context '1st column' do
        subject { build_result.columns[0] }
        its(:header) { should == column_headers[0] }
        its(:data) { should == column_0 }
        its(:total) { should == column_totals[0] }
      end

      context '2nd column' do
        subject { build_result.columns[1] }
        its(:header) { should == column_headers[1] }
        its(:data) { should == column_1 }
        its(:total) { should == column_totals[1] }
      end

      context '3rd column' do
        subject { build_result.columns[2] }
        its(:header) { should == column_headers[2] }
        its(:data) { should == column_2 }
        its(:total) { should == column_totals[2] }
      end
    end

    describe 'rows' do
      let(:build_result) { instance.build }
      specify { build_result.rows.length.should == 2 }

      context 'row headers' do
        subject { build_result.row_headers }
        it { should == row_headers }
      end

      context '1st row' do
        subject { build_result.rows[0] }
        its(:header) { should == row_headers[0] }
        its(:data) { should == row_0 }
        its(:total) { should == row_totals[0] }
      end

      context '2nd row' do
        subject { build_result.rows[1] }
        its(:header) { should == row_headers[1] }
        its(:data) { should == row_1 }
        its(:total) { should == row_totals[1] }
      end
    end

    describe 'data grid' do
      let(:build_result) { instance.build }

      context 'preparing the grid' do
        subject { build_result.prepare_grid }
        it { should == [[nil, nil, nil], [nil, nil, nil]] }
      end

      context 'populating the grid' do
        subject { build_result.data_grid }
        it { should == [[d1, d2, d3], [d4, d5, d6]] }
      end

      context 'totals' do
        subject { build_result }
        its(:column_totals) { should == column_totals }
        its(:row_totals) { should == row_totals }
        its(:grand_total) { should == grand_total }
      end
    end
  end
end
