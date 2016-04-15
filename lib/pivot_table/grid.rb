module PivotTable
  class Grid

    attr_accessor :source_data, :row_name, :column_name, :value_name, :field_name
    attr_reader :columns, :rows, :data_grid, :configuration

    DEFAULT_OPTIONS = {
      :sort => true
    }

    def initialize(opts = {}, &block)
      yield(self) if block_given?
      @configuration = Configuration.new(DEFAULT_OPTIONS.merge(opts))
    end

    def build
      populate_grid
      build_rows
      build_columns
      self
    end

    def build_rows
      @rows = []
      @data_grid.each_with_index do |data, index|
        @rows << Row.new(
          :header     => row_headers[index],
          :data       => data,
          :value_name => value_name,
          :orthogonal_headers => column_headers
        )
      end
    end

    def build_columns
      @columns = []
      @data_grid.transpose.each_with_index do |data, index|
        @columns << Column.new(
          :header           => column_headers[index],
          :data             => data,
          :value_name       => value_name,
          :orthogonal_headers => row_headers
        )
      end
    end

    def column_headers
      @column_headers ||= headers @column_name
    end

    def row_headers
      @row_headers ||= headers @row_name
    end

    def column_totals
      columns.map { |c| c.total }
    end

    def row_totals
      rows.map { |r| r.total }
    end

    def grand_total
      column_totals.inject(0) { |t, x| t + x }
    end

    def prepare_grid
      @data_grid = []
      row_headers.count.times do
        @data_grid << column_headers.count.times.inject([]) { |col| col << nil }
      end
      @data_grid
    end

    def populate_grid
      prepare_grid
      row_headers.each_with_index do |row, row_index|
        @data_grid[row_index] = build_data_row(row)
      end
      @data_grid
    end

    private

    def headers(method)
      hdrs = @source_data.collect { |c| c.send method }.uniq
      configuration.sort ? hdrs.sort : hdrs
    end

    def build_data_row(row)
      current_row = []
      column_headers.each_with_index do |col, col_index|
        current_row[col_index] = derive_row_value(row, col)
      end
      current_row
    end

    def find_data_item(row, col)
      @source_data.find do |item|
        item.send(row_name) == row && item.send(column_name) == col
      end
    end

    def derive_row_value(row, col)
      data_item = find_data_item(row, col)
      if has_field_name?(data_item)
        data_item.send(field_name)
      else
        data_item
      end
    end

    def has_field_name?(data_item)
      !!(field_name && data_item.respond_to?(field_name))
    end
  end
end
