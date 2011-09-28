module PivotTable
  class Row

    ACCESSORS = [:header, :data, :total]

    ACCESSORS.each do |a|
      self.send(:attr_accessor, a)
    end

    def initialize(options = {})
      ACCESSORS.each do |a|
        self.send("#{a}=", options[a]) if options.has_key?(a)
      end
    end

  end
end