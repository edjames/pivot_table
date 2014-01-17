module PivotTable
  class Configuration

    def initialize(opts = {})
      @opts = opts
    end

    def method_missing(method_name, *arguments, &block)
      @opts[method_name]
    end

  end
end
