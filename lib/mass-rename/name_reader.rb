# encoding: utf-8

module MassRename
  class NameReader
    include Enumerable
    
    def initialize(data, reader_class = File)
      @data = if data.is_a? Array
        data
      else
        reader_class.read(data).split("\n")
      end
    end
    
    def each
      if block_given?
        @data.each do |datum|
          yield datum
        end
      else
        Enumerator.new(@data)
      end
    end
  end
end