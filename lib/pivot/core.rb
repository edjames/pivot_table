module Pivot
  class Core

    def initialize

    end

    def generate data
      cols = data.map(&:qtr).uniq.sort
      rows = data.map(&:city).uniq.sort

      cross_tab = []

      rows.each do |row|
        row_data = []

        cols.each do |col|

          row_values = data.map { |dr| (dr.sales || 0) if dr.city == row && dr.qtr == col }.compact
          row_data << row_values.inject { |value, sum = 0| sum += value }

        end

        row_total = row_data.inject { |value, sum = 0| sum += value }
        row_data << row_total
        row_data.unshift row
        cross_tab << row_data
      end

      totals = ['Total'] + cols.map { 0 }.unshift(0)
      cross_tab.each do |row|
        row[1..-1].each_with_index { |val, index| totals[index+1] += val }
      end
      cross_tab << totals

      cross_tab.unshift(cols.insert(0, '') + ['Total'])

      cross_tab
    end

  end
end