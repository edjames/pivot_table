module PivotTable
  class Column
    include CellCollection

    def row_data row_header
      find_data row_header
    end
  end
end
