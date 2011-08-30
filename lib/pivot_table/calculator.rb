require 'spec_helper'

module PivotTable
  module Calculator

    def array_sum array
      array.inject(0) { |sum, value| sum += value }
    end

    def append_row_totals grid
      grid.each { |row| row << array_sum(row) }
    end

    def column_totals grid
      numeric_data = grid.dup
      numeric_data.transpose.map { |row| array_sum row }
    end

  end
end