# encoding: utf-8

require 'optparse'
require_relative 'name_generator'

module MassRename
  class Options

    attr_reader :files
    attr_reader :name_file
    attr_reader :minimum_width
    attr_reader :variable_width
    attr_reader :lead_with_spaces
    attr_reader :start
    attr_reader :pretend
    attr_reader :prefix
    attr_reader :suffix
    attr_reader :separator
    attr_reader :format
    
    def initialize(argv, name_generator_class)
      @name_generator_class = name_generator_class
      @pretend              = false
      @minimum_width        = nil
      @variable_width       = false
      @lead_with_spaces     = false
      @start                = 1
      @prefix               = ''
      @suffix               = ''
      @separator            = ' '
      @format               = nil
      @name_file            = nil
      parse(argv)
      @files = argv
    end
    
    private
    
    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = 'Usage: mass-rename [ options ] files'
        
        opts.on('-h', '--help', 'Show this message') do
          puts opts
          exit
        end
        
        opts.on('--pretend', 'Only print the renames, don\'t execute them') do
          @pretend = false
        end
        
        opts.on('-n', '--name-file=FILE', String, 'Read names for renaming from FILE') do |file|
          @name_file = file
        end
        
        opts.on('-w', '--minimum-width=WIDTH', Integer, 'Force the number to be a minimum width (will be filled with zeros unless --space is set)') do |width|
          @minimum_width = width
        end
        
        opts.on('--variable-width', 'Don\'t make all numbers the same width') do
          @variable_width = true
        end
        
        opts.on('--spaces', 'Lead fixed width numbers with spaces') do
          @lead_with_spaces = true
        end
        
        opts.on('-S' ,'--start=NUM', Integer, 'Start counting at NUM') do |start|
          @start = start
        end  
        
        opts.on('-p', '--prefix=PREFIX', String, 'Prefix the names with PREFIX') do |prefix|
          @prefix = prefix
        end

        opts.on('-s', '--suffix=SUFFIX', String, 'Suffix the names with SUFFIX') do |suffix|
          @suffix = suffix
        end
        
        opts.on('--separator=SEP', String, 'Replace the space between number and name with SEP') do |separator|
          @separator = separator
        end
        
        opts.on('--format=FORMAT', String, "Completely define the naming format (#{@name_generator_class::NUM_PLACEHOLDER} and #{@name_generator_class::NAME_PLACEHOLDER} will be replaced). Overrides --prefix, --suffix and --separator") do |format|
          @format = @name_generator_class.valid_format?(format) ? format : nil
        end
        
        begin
          argv = ['--help'] if argv.empty?
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
        end
      end
    end
    
  end
end
