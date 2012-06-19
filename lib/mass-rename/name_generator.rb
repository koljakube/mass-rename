# encoding: utf-8

module MassRename
  class NameGenerator

    NUM_PLACEHOLDER  = '%num%'
    NAME_PLACEHOLDER = '%name%'
    
    def initialize(names, number_string_generator, options = {})
      @names                   = names
      @number_string_generator = number_string_generator
      @prefix                  = options.fetch(:prefix, '')
      @suffix                  = options.fetch(:suffix, '')
      @separator               = options.fetch(:separator, ' ')
      @format                  = options.fetch(:format, nil)
      @data                    = generate
    end
    
    def each
      if block_given?
        enum = @number_string_generator.each
        @names.each do |name|
          yield format(enum.next, name)
        end
      else
        Enumerator.new(@data)
      end
    end
    
    def self.valid_format?(format)
      (format =~ /#{NUM_PLACEHOLDER}/) or (format =~ /#{NAME_PLACEHOLDER}/)
    end
    
    private
        
    def format(num, name)
      unless @format.nil?
        args = if (@format =~ /#{NUM_PLACEHOLDER}/) < (@format =~ /#{NAME_PLACEHOLDER}/)
          [num, name]
        else
          [name, num]
        end
        sprintf(@format.gsub(/%num%|%name%/, '%s'), *args)
      else
        if name.empty?
          sprintf("%s%s%s", @prefix, num, @suffix)
        else
          sprintf("%s%s%s%s%s", @prefix, num, @separator, name, @suffix)
        end
      end
    end
    
    def generate
      enum = @number_string_generator.each
      @names.collect{ |name|
        format(enum.next, name)
      }
    end

  end
end
