module Pivot
  class Table

    attr_accessor :data, :column, :row, :pivot_on

    def initialize(&block)
      yield(self) if block_given?
    end

    def column_headers
      @data.collect { |c| c.send @column }.uniq.sort
    end

    def row_headers
      @data.collect { |r| r.send @row }.uniq.sort
    end

    def pivoted_row_data
      row_headers.inject([]) do |result, rh|
        row = column_headers.inject([]) do |arr, ch|
          arr << @data.collect { |d| d.send @pivot_on if d.send(@row) == rh && d.send(@column) == ch }.compact
        end
        result << row.flatten.unshift(rh)
      end
    end

    def row_sum row
      row.reject { |value| value.kind_of? String }.inject(0) { |sum, value| sum += value }
    end

    def insert_row_totals data
      data.map { |row| row << row_sum(row) }
    end

    def column_totals data
      numeric_data = data.dup
      numeric_data.map! { |row| row.reject { |value| value.kind_of? String } }
      numeric_data.transpose.map { |row| row_sum row }
    end

    def generate
      headers = column_headers.unshift('') << 'Total'
      rows    = insert_row_totals pivoted_row_data
      totals  = column_totals(rows).unshift 'Total'

      {
          :headers => headers,
          :rows    => rows,
          :totals  => totals
      }
    end
  end
end