module PivotTable
  class Column

    ACCESSORS = [:header, :data, :value_name]

    ACCESSORS.each do |a|
      self.send(:attr_accessor, a)
    end

    def initialize(options = {})
      ACCESSORS.each do |a|
        self.send("#{a}=", options[a]) if options.has_key?(a)
      end
    end

    def total
      data.inject(0){|t,x| t + (x ? x.send(value_name) : 0)}
    end

  end
end
