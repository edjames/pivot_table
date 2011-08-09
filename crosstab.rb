require 'ostruct'

data = []
data << OpenStruct.new(:city => 'London', :qtr => 1, :sales => nil)
data << OpenStruct.new(:city => 'London', :qtr => 1, :sales => 50)
data << OpenStruct.new(:city => 'London', :qtr => 1, :sales => 50)
data << OpenStruct.new(:city => 'London', :qtr => 2, :sales => 200)
data << OpenStruct.new(:city => 'London', :qtr => 3, :sales => 300)
data << OpenStruct.new(:city => 'London', :qtr => 4, :sales => 400)

data << OpenStruct.new(:city => 'Tokyo', :qtr => 1, :sales => 1000)
data << OpenStruct.new(:city => 'Tokyo', :qtr => 2, :sales => 2000)
data << OpenStruct.new(:city => 'Tokyo', :qtr => 3, :sales => 3000)
data << OpenStruct.new(:city => 'Tokyo', :qtr => 4, :sales => 4000)

data << OpenStruct.new(:city => 'New York', :qtr => 1, :sales => 10)
data << OpenStruct.new(:city => 'New York', :qtr => 2, :sales => 20)
data << OpenStruct.new(:city => 'New York', :qtr => 3, :sales => 30)
data << OpenStruct.new(:city => 'New York', :qtr => 4, :sales => 40)

cols = data.map(&:qtr).uniq.sort
rows = data.map(&:city).uniq.sort

cross_tab = []

rows.each do |row|  
  row_data = []
  
  cols.each do |col|
    
    row_values = data.map{|dr| (dr.sales || 0) if dr.city == row && dr.qtr == col}.compact
    row_data << row_values.inject{|value, sum = 0| sum += value}

  end
  
  row_total = row_data.inject{|value, sum = 0| sum += value}
  row_data << row_total
  row_data.unshift row
  cross_tab << row_data
end

totals = ['Total'] + cols.map{0}.unshift(0)
cross_tab.each do |row|
  row[1..-1].each_with_index{|val, index| totals[index+1] += val}
end
cross_tab << totals

cross_tab.unshift(cols.insert(0, '') + ['Total'])

cross_tab.each do |row|
  row.each {|i| print "%-10s" % i.to_s}
  puts
end
