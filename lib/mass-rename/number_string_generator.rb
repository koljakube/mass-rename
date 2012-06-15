# encoding: utf-8

module MassRename
  class NumberStringGenerator
    include Enumerable
    
    def initialize(range, options = {})
      @range  = range
      @width  = options.fetch(:width, nil)
      @filler = options.fetch(:lead_with_spaces, false) ? ' ' : '0'
      @data   = generate
    end
        
    def each
      if block_given?
        @data.each do |el|
          yield el
        end
      else
        Enumerator.new(@data)
      end
    end
    
    def self.needed_width(count)
      String(count).length
    end
    
    private
    
    def formatted_number(number, width, filler)
      format_string = unless width.nil?
        "%#{filler}#{width}d"
      else
        "%d"
      end
      sprintf(format_string, number)
    end
    
    def generate
      Array(@range).collect{|el| formatted_number(el, @width, @filler)}
    end
       
  end
end