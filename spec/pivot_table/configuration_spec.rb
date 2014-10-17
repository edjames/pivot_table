require 'spec_helper'

module PivotTable
  describe Configuration do

    subject { described_class.new opts }

    let(:opts) { { :sort => true, :other_setting => 'on' } }

    its(:sort) { is_expected.to eq true }
    its(:other_setting) { is_expected.to eq 'on' }

    context 'when setting does not exist' do
      its(:i_do_not_exist) { is_expected.to be_nil }
    end

  end
end
