shared_examples 'a collection of rows' do
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
