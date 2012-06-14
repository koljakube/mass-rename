# encoding: utf-8

module MassRename
  class NumberStringGenerator
    def initialize(options = {})
      @start  = options.has_key?(:range) ? options[:range].min : 1
      @end    = options.has_key?(:range) ? options[:range].max : nil
      @number = @start
      @width  = options.fetch(:width, nil)
      @filler = options.fetch(:lead_with_spaces, false) ? ' ' : '0'
    end
    
    def next_number
      if not @end.nil? and @number > @end
        return nil
      end
      result = formatted_number
      @number = @number.next
      result
    end
    
    def all_numbers(&block)
      raise RuntimeError.new "can't use all_numbers without an end" if @end.nil?
        
      while @number <= @end
        yield formatted_number
        next!
      end
      nil
    end
    
    private
    
    def formatted_number
      format_string = unless @width.nil?
        "%#{@filler}#{@width}d"
      else
        "%d"
      end
      sprintf(format_string, @number)
    end
    
    def next!
      @number +=  1
    end
  end
end