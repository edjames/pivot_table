shared_examples 'a collection of columns' do
  let(:build_result) { instance.build }

  context 'column count' do
    subject { build_result.columns.length }
    it { is_expected.to eq 3 }
  end

  context 'column headers' do
    subject { build_result.column_headers }
    it { is_expected.to eq column_headers }
  end

  context '1st column' do
    subject { build_result.columns[0] }
    its(:header) { is_expected.to eq column_headers[0] }
    its(:data) { is_expected.to eq column_0 }
    its(:total) { is_expected.to eq column_totals[0] }
  end

  context '2nd column' do
    subject { build_result.columns[1] }
    its(:header) { is_expected.to eq column_headers[1] }
    its(:data) { is_expected.to eq column_1 }
    its(:total) { is_expected.to eq column_totals[1] }
  end

  context '3rd column' do
    subject { build_result.columns[2] }
    its(:header) { is_expected.to eq column_headers[2] }
    its(:data) { is_expected.to eq column_2 }
    its(:total) { is_expected.to eq column_totals[2] }
  end
end
