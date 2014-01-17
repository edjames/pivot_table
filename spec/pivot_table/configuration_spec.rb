require 'spec_helper'

module PivotTable
  describe Configuration do

    subject { described_class.new opts }

    let(:opts) { { :sort => true, :other_setting => 'on' } }

    its(:sort) { should be_true }
    its(:other_setting) { should == 'on' }

    context 'when setting does not exist' do
      its(:i_do_not_exist) { should be_nil }
    end

  end
end
