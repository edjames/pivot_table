shared_examples "a cell collection" do
  it { is_expected.to respond_to :header }
  it { is_expected.to respond_to :data }
  it { is_expected.to respond_to :value_name }
  it { is_expected.to respond_to :total }
  it { is_expected.to respond_to :orthogonal_headers }

  subject(:instance) { klass.new(attrs) }

  let(:data) do
    { a: 1, b: 2 }
  end

  let(:attrs) do
    { header: 'header', data: data.values, value_name: "value_name", orthogonal_headers: data.keys }
  end

  context 'initialize with hash' do
    its(:header) { is_expected.to eq attrs[:header] }
    its(:data) { is_expected.to eq attrs[:data] }
    its(:value_name) { is_expected.to eq attrs[:value_name] }
    its(:orthogonal_headers) { is_expected.to eq attrs[:orthogonal_headers] }
  end

  it "finds data by orthogonal header name" do
    expect(instance.send :find_data, :a).to equal(data[:a])
    expect(instance.send :find_data, :b).to equal(data[:b])
    expect(instance.send :find_data, :c).to be_nil
  end
end
