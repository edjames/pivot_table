module PivotTable
  class Table
    include Calculator
    include Reader

    attr_accessor :data, :column, :row, :pivot_on

    def initialize(&block)
      yield(self) if block_given?
    end

    def column_headers
      uniq_values @data, @column
    end

    def row_headers
      uniq_values @data, @row
    end

    def initialize_grid(rows, columns, default_value = 0)
      @grid = []
      rows.times do
        @grid << columns.times.inject([]) { |col| col << default_value }
      end
      @grid
    end

    def matching_data(row_header, column_header)
      filter @data, @row, row_header, @column, column_header
    end

    def populate_grid
      row_headers.each_with_index do |row_header, row_index|
        column_headers.each_with_index do |column_header, column_index|
          collected                      = matching_data row_header, column_header
          total                          = collected.inject(0) { |sum, item| sum += item.send(@pivot_on) }
          @grid[row_index][column_index] += total
        end
      end
      @grid
    end

    def row_sum row
      array_sum row
    end

    def calculate_row_totals
      append_row_totals @grid
    end

    def add_row_headers
      @grid.each_with_index do |row, index|
        row.unshift row_headers[index]
      end
    end

    def calculate_column_totals data
      column_totals data
    end

    def generate
      initialize_grid row_headers.size, column_headers.size, 0
      populate_grid
      calculate_row_totals
      totals = calculate_column_totals @grid

      {
          :headers => ['', column_headers, 'Total'].flatten,
          :rows    => add_row_headers,
          :totals  => ['Total', totals].flatten
      }
    end
  end
end
