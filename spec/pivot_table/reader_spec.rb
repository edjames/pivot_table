require 'spec_helper'

module PivotTable
  describe Reader do
    class TestClass
      include Reader
    end

    before do
      @data     = [
          OpenStruct.new(:header => 'Zero'),
          OpenStruct.new(:header => 'One'),
          OpenStruct.new(:header => 'Two')
      ]
      @instance = TestClass.new
    end

    context 'reading headers from collection' do
      subject { @instance.headers @data, :header }
      it { should == %w(One Two Zero) }
    end

  end
end