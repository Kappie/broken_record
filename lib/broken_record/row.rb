module BrokenRecord
  class Row
    def initialize(params)
      self.data = {}

      column_names = params.fetch(:column_names)
      values       = params.fetch(:values)

      column_names.each do |name|
        data[name] = values[name]
      end

      build_accessors(column_names)
    end

    def to_hash
      data
    end

    private

    attr_accessor :data

    def build_accessors(column_names)
      column_names.each do |name|
        singleton_class.send(:define_method, name) { data[name] }

        singleton_class.send(:define_method, "#{name}=") do |v| 
          data[name] = v
        end
      end
    end
  end
end