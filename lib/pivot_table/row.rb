module PivotTable
  class Row
    include CellCollection

    def column_data column_header
      find_data column_header
    end
  end
end
