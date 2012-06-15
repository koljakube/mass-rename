require 'optparse'

require_relative 'name_generator'

module MassRename
  class Options

    attr_reader :files
    attr_reader :minimum_width
    attr_reader :variable_width
    attr_reader :lead_with_spaces
    attr_reader :pretend
    attr_reader :prefix
    attr_reader :suffix
    attr_reader :separator
    attr_reader :format
    
    def intialize(argv)
      @pretend          = false
      @minimum_width    = nil
      @variable_width   = false
      @lead_with_spaces = false
      @prefix           = ''
      @suffix           = ''
      @separator        = ' '
      @format           = nil
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
        
        opts.on('-w', '--minimum-width=WIDTH', Integer, 'Force the number to be a minimum width (will be filled with zeros unless --space is set)') do |width|
          @minimum_width = width
        end
        
        opts.on('--variable-width', 'Don\'t make all numbers the same width') do
          @variable_width = true
        end
        
        opts.on('--spaces', 'Lead fixed width numbers with spaces') do
          @lead_with_spaces = true
        end
        
        opts.on('-p', '--prefix PREFIX', 'Prefix the names with PREFIX') do |prefix|
          @prefix = prefix
        end

        opts.on('-s', '--suffix SUFFIX', 'Suffix the names with SUFFIX') do |suffix|
          @suffix = suffix
        end
        
        opts.on('--separator SEP', String, 'Replace the space between number and name with SEP') do |separator|
          @separator = separator
        end
        
        opts.on('--format FORMAT', String, "Completely define the naming format (#{NameGenerator.NUM_PLACEHOLDER} and #{NameGenerator.NAME_PLACEHOLDER} will be replaced). Overrides --prefix, --suffix and --separator") do |format|
          @format = NameGenerator.valid_format? format ? format : nil
        end
        
        puts opts
      end
    end
    
  end
end
