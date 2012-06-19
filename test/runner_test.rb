# encoding: utf-8

require_relative 'test_helper'

class RunnerTest < TestCase
  
  class NSG
    
    attr_reader :range, :width, :lead_with_spaces
    
    def initialize(range, options = {})
      @@instance = self
      @range            = range
      @width            = options.fetch(:width, nil)
      @lead_with_spaces = options.fetch(:lead_with_spaces, nil)
    end
    
    def self.instance
      @@instance
    end
    
    def self.needed_width(str)
      MassRename::NumberStringGenerator.needed_width(str)
    end
    
  end
  
  class NG
    NUM_PLACEHOLDER  = MassRename::NameGenerator::NUM_PLACEHOLDER
    NAME_PLACEHOLDER = MassRename::NameGenerator::NAME_PLACEHOLDER
    
    attr_reader :prefix, :suffix, :separator, :format
    
    def initialize(names, nsg, options = {})
      @@instance = self
      @prefix    = options[:prefix]
      @suffix    = options[:suffix]
      @separator = options[:separator]
      @format    = options[:format]
    end
    
    def names
      []
    end
    
    def self.instance
      @@instance
    end
    
    def self.valid_format?(format)
      MassRename::NameGenerator.valid_format? format
    end
    
  end
  
  test 'passes parameters correctly to the number string generator' do
    argv = %w{ --minimum-width=5 --spaces }
    runner = Runner.new(argv, NSG, NG)
    assert_equal 5, NSG.instance.width
    assert_equal true, NSG.instance.lead_with_spaces
  end
  
  test 'passes parameters correctly to the name generator' do
    format = NG::NUM_PLACEHOLDER + NG::NAME_PLACEHOLDER
    argv = %w{ --prefix=prefix --suffix=suffix --separator=separator } + ["--format=#{format}"]
    runner = Runner.new(argv, NSG, NG)
    assert_equal 'prefix', NG.instance.prefix
    assert_equal 'suffix', NG.instance.suffix
    assert_equal 'separator', NG.instance.separator
    assert_equal format, NG.instance.format
  end
  
end
