shared_examples 'a data grid' do
  let(:build_result) { instance.build }

  context 'preparing the grid' do
    subject { build_result.prepare_grid }
    it { is_expected.to eq [[nil, nil, nil], [nil, nil, nil]] }
  end

  context 'populating the grid' do
    subject { build_result.data_grid }
    it { is_expected.to eq [row_0, row_1] }
  end

  context 'totals' do
    subject { build_result }
    its(:column_totals) { is_expected.to eq column_totals }
    its(:row_totals) { is_expected.to eq row_totals }
    its(:grand_total) { is_expected.to eq grand_total }
  end
end
