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
    let(:row_1) { ['r1', d1, d2, d3] }
    let(:row_2) { ['r2', d4, d5, d6] }
    let(:grid) { [row_1, row_2] }

    let(:instance) do
      Grid.new do |g|
        g.data        = data
        g.row_name    = :row_name
        g.column_name = :column_name
      end
    end

    context 'accessors' do
      subject { Grid.new }
      it { should respond_to :data }
      it { should respond_to :row_name }
      it { should respond_to :column_name }
    end


    context 'build result' do
      subject { instance.build }

      it { should respond_to :headers }
      it { should respond_to :rows }
      specify { subject.headers.should == column_headers }
      specify { subject.rows.should == [row_1, row_2] }
    end

    context 'column headers' do
      subject { instance.column_headers }
      it { should == column_headers }
    end

    context 'row headers' do
      subject { instance.row_headers }
      it { should == row_headers }
    end

    context 'result grid' do
      context 'initializing the grid' do
        subject { instance.prepare_grid }
        it { should == [[nil, nil, nil], [nil, nil, nil]] }
      end

      context 'with balanced data' do
        subject { instance.grid_of_objects }
        specify { subject.length.should == 2 }
        specify { subject[0].should == row_1 }
        specify { subject[1].should == row_2 }
      end

      context 'with unbalanced data' do
        let(:new_object) { build_object(1, 'r1', 'c4') }
        before do
          data << new_object
        end
        subject { instance.grid_of_objects }
        specify { subject.length.should == 2 }
        specify { subject[0].should == row_1 << new_object }
      end
    end

  end
end