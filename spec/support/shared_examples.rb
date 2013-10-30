shared_examples "a cell collection" do

  it { should respond_to :header }
  it { should respond_to :data }
  it { should respond_to :value_name }
  it { should respond_to :total }

  context 'initialize with hash' do
    subject { klass.new(attrs) }

    let(:attrs) do
      { header: 'header', data: 'data', value_name: "value_name" }
    end

    its(:header) { should == attrs[:header] }
    its(:data) { should == attrs[:data] }
    its(:value_name) { should == attrs[:value_name] }
  end

end
