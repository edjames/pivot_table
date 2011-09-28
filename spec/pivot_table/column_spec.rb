require "spec_helper"

module PivotTable
  describe Column do

    let(:klass) { Column }

    before { @instance = klass.new }

    it { should respond_to :header }
    it { should respond_to :data }
    it { should respond_to :total }

    context 'initialize with hash' do
      subject { klass.new(header: 'header', data: 'data', total: 'total')}

      its(:header) { should == 'header' }
      its(:data) { should == 'data' }
      its(:total) { should == 'total' }
    end

  end
end