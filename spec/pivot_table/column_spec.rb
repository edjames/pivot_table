require "spec_helper"

module PivotTable
  describe Column do

    let(:klass) { Column }
    it_should_behave_like "a cell collection"

  end
end
