module PivotTable
  module Reader

    def uniq_values collection, method
      collection.collect { |c| c.send method }.uniq.sort
    end

    def matching_data collection, row_method, row_header, col_method, col_header
      collection.select { |item| item.send(row_method) == row_header && item.send(col_method) == col_header }
    end

  end
end