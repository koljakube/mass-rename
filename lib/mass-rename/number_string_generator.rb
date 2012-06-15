# encoding: utf-8

module MassRename
  class NumberStringGenerator
    include Enumerable
    
    def initialize(range, options = {})
      width  = options.fetch(:width, nil)
      filler = options.fetch(:lead_with_spaces, false) ? ' ' : '0'
      @data   = generate_numbers(range, width, filler)
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
    
    private
    
    def formatted_number(number, width, filler)
      format_string = unless width.nil?
        "%#{filler}#{width}d"
      else
        "%d"
      end
      sprintf(format_string, number)
    end
    
    def generate_numbers(range, width, filler)
      Array(range).collect{|el| formatted_number(el, width, filler)}
    end
      
    
    def next!
      @number +=  1
    end
  end
end