# encoding: utf-8

require_relative 'options'
require_relative 'number_string_generator'
require_relative 'name_generator'

module MassRename
  class Runner
    
    def initialize(argv, number_string_generator_class = NumberStringGenerator, name_generator_class = NameGenerator, name_reader_class = NameReader)
      @options = Options.new(argv, name_generator_class)
      @files   = @options.files

      names = if @options.name_file.nil?
        [''] * @files.count
      else
        Array(name_reader_class.new(@options.name_file))
      end
      range = @options.start..(@options.start + names.count)

      nsg_options = {}
      nsg_options[:lead_with_spaces] = true if @options.lead_with_spaces
      nsg_options[:width] = number_string_generator_class.needed_width(range.max) unless @options.variable_width
      nsg_options[:width] = @options.minimum_width unless @options.minimum_width.nil?
      @number_string_generator = number_string_generator_class.new(range, nsg_options)
      
      ng_options = {}
      ng_options[:prefix]    = @options.prefix
      ng_options[:suffix]    = @options.suffix
      ng_options[:separator] = @options.separator
      ng_options[:format]    = @options.format
      @name_generator = name_generator_class.new(names, @number_string_generator, ng_options)
      
      @renamer = Renamer.new(@options.files, @name_generator.names)
    end
    
    def run
      unless @options.pretend
        @renamer.rename!
      else
        @renamer.renames.each do |from, to|
          puts "Would rename #{from} to #{to}."
        end
      end
    end
    
  end
end