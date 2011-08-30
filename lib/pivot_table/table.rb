module PivotTable
  class Table

    attr_accessor :data, :column, :row, :pivot_on

    def initialize(&block)
      yield(self) if block_given?
    end

    #reader
    def column_headers
      @data.collect { |c| c.send @column }.uniq.sort
    end

    #reader
    def row_headers
      @data.collect { |r| r.send @row }.uniq.sort
    end

    def initialize_grid(rows, columns, default_value = 0)
      @grid = []
      rows.times do
        @grid << columns.times.inject([]) { |col| col << default_value }
      end
      @grid
    end

    #reader
    def matching_data(row_header, column_header)
      data.select { |item| item.send(@row) == row_header && item.send(@column) == column_header }
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

    #calc
    def row_sum row
      row.inject(0) { |sum, value| sum += value }
    end

    #calc
    def calculate_row_totals
      @grid.each { |row| row << row_sum(row) }
    end

    def add_row_headers
      @grid.each_with_index do |row, index|
        row.unshift row_headers[index]
      end
    end

    #calc
    def calculate_column_totals data
      numeric_data = data.dup
      numeric_data.transpose.map { |row| row_sum row }
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
