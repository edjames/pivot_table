shared_examples 'a data grid' do
  let(:build_result) { instance.build }

  context 'preparing the grid' do
    subject { build_result.prepare_grid }
    it { should == [[nil, nil, nil], [nil, nil, nil]] }
  end

  context 'populating the grid' do
    subject { build_result.data_grid }
    it { should == [row_0, row_1] }
  end

  context 'totals' do
    subject { build_result }
    its(:column_totals) { should == column_totals }
    its(:row_totals) { should == row_totals }
    its(:grand_total) { should == grand_total }
  end
end
