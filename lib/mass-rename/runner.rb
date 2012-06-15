# encoding: utf-8

require_relative 'options'
require_relative 'number_string_generator'
require_relative 'name_generator'

module MassRename
  class Runner
    
    def initialize(argv)
      @options = Options.new(argv)
      @files   = @options.files

      names = if @options.name_file.nil?
        [''] * @files.count
      else
        Array(NameReader.new(@options.name_file))
      end
      range = @options.start..(@options.start + names.count)

      nsg_options = {}
      nsg_options[:lead_with_spaces] = true if @options.lead_with_spaces
      nsg_options[:width] = NumberStringGenerator.needed_width(range.max) unless @options.variable_width
      nsg_options[:width] = @options.minimum_width unless @options.minimum_width.nil?
      @number_string_generator = NumberStringGenerator.new(range, nsg_options)
      
      ng_options = {}
      ng_options[:prefix]    = @options.prefix
      ng_options[:suffix]    = @options.suffix
      ng_options[:separator] = @options.separator
      ng_options[:format]    = @options.format
      @name_generator = NameGenerator.new(names, @number_string_generator, ng_options)
    end
    
    def run
      @name_generator.each do |name|
        puts name
      end
    end
    
  end
end