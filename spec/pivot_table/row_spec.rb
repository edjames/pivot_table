require 'spec_helper'

module PivotTable
  describe Row do

    let(:klass) { Row }
    it_should_behave_like 'a cell collection'

  end
end
