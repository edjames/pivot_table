shared_examples 'a collection of rows' do
  let(:build_result) { instance.build }

  context 'row count' do
    subject { build_result.rows.length }
    it { is_expected.to eq 2 }
  end

  context 'row headers' do
    subject { build_result.row_headers }
    it { is_expected.to eq row_headers }
  end

  context '1st row' do
    subject { build_result.rows[0] }
    its(:header) { is_expected.to eq row_headers[0] }
    its(:data) { is_expected.to eq row_0 }
    its(:total) { is_expected.to eq row_totals[0] }
  end

  context '2nd row' do
    subject { build_result.rows[1] }
    its(:header) { is_expected.to eq row_headers[1] }
    its(:data) { is_expected.to eq row_1 }
    its(:total) { is_expected.to eq row_totals[1] }
  end
end
