shared_examples 'a collection of columns' do
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
