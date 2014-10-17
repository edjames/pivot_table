shared_examples "a cell collection" do
  it { is_expected.to respond_to :header }
  it { is_expected.to respond_to :data }
  it { is_expected.to respond_to :value_name }
  it { is_expected.to respond_to :total }

  context 'initialize with hash' do
    subject { klass.new(attrs) }

    let(:attrs) do
      { header: 'header', data: 'data', value_name: "value_name" }
    end

    its(:header) { is_expected.to eq attrs[:header] }
    its(:data) { is_expected.to eq attrs[:data] }
    its(:value_name) { is_expected.to eq attrs[:value_name] }
  end
end
