require 'spec_helper'

module Pivot
  describe Simple do

    it "should do something" do
      @data = []
      @data << OpenStruct.new(:city => 'London', :qtr => 1, :sales => nil)
      @data << OpenStruct.new(:city => 'London', :qtr => 1, :sales => 50)
      @data << OpenStruct.new(:city => 'London', :qtr => 1, :sales => 50)
      @data << OpenStruct.new(:city => 'London', :qtr => 2, :sales => 200)
      @data << OpenStruct.new(:city => 'London', :qtr => 3, :sales => 300)
      @data << OpenStruct.new(:city => 'London', :qtr => 4, :sales => 400)

      @data << OpenStruct.new(:city => 'Tokyo', :qtr => 1, :sales => 1000)
      @data << OpenStruct.new(:city => 'Tokyo', :qtr => 2, :sales => 2000)
      @data << OpenStruct.new(:city => 'Tokyo', :qtr => 3, :sales => 3000)
      @data << OpenStruct.new(:city => 'Tokyo', :qtr => 4, :sales => 4000)

      @data << OpenStruct.new(:city => 'New York', :qtr => 1, :sales => 10)
      @data << OpenStruct.new(:city => 'New York', :qtr => 2, :sales => 20)
      @data << OpenStruct.new(:city => 'New York', :qtr => 3, :sales => 30)
      @data << OpenStruct.new(:city => 'New York', :qtr => 4, :sales => 40)

      instance = Simple.new

      result = instance.generate @data

      result.should == [["", 1, 2, 3, 4, "Total"], ["London", 100, 200, 300, 400, 1000], ["New York", 10, 20, 30, 40, 100], ["Tokyo", 1000, 2000, 3000, 4000, 10000], ["Total", 1110, 2220, 3330, 4440, 11100]]

    end

  end
end