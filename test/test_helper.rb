# encoding: utf-8

require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/mass-rename'
require_relative '../lib/mass-rename/runner'


class TestCase < MiniTest::Unit::TestCase
  include MassRename
  
  class << self
    alias_method :old_test, :test
      
    def test(name, &block)
      name = "test_#{name.gsub(/[^\w ]/, '').gsub(' ', '_')}"
      define_method name, &block
    end
    
    def setup(&block)
      define_method :setup, &block
    end
    
    def teardown(&block)
      define_method :teardown, &block
    end
  end
end
