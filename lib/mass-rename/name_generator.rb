# encoding: utf-8

module MassRename
  class NameGenerator
    
    def initialize(names)
      @names                   = names
      @number_string_generator = NumberStringGenerator.new width: needed_width(@names.count)
      @numstring_enum          = @number_string_generator.each_entry
      @name_enum               = @names.each_entry
    end
    
    def generate
      format
    end
    
    private
    
    def format
      sprintf("%s %s", @numstring_enum.next, @name_enum.next)
    end
    
    def needed_width(num)
      String(num).length
    end

  end
end
