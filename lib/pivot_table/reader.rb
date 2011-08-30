module PivotTable
  module Reader

    def headers collection, method
      collection.collect { |c| c.send method }.uniq.sort
    end

  end
end