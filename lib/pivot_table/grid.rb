module PivotTable
  class Grid

    attr_accessor :data, :row_name, :column_name

    def initialize(&block)
      yield(self) if block_given?
    end

    def build
      OpenStruct.new(
          headers: column_headers,
          rows:    grid_of_objects
      )
    end

    def column_headers
      headers @column_name
    end

    def row_headers
      headers @row_name
    end

    def prepare_grid
      nil_grid = []
      row_headers.count.times do
        nil_grid << column_headers.count.times.inject([]) { |col| col << nil }
      end
      nil_grid
    end

    def grid_of_objects
      result = prepare_grid
      row_headers.each_with_index do |row, row_index|
        current_row = []
        column_headers.each_with_index do |col, col_index|
          current_row[col_index] = @data.find { |item| item.send(row_name) == row && item.send(column_name) == col }
        end
        result[row_index] = current_row.unshift(row)
      end
      result
    end

    private
    def headers method
      @data.collect { |c| c.send method }.uniq.sort
    end

  end
end