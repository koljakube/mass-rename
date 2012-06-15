# encoding: utf-8

require_relative 'test_helper'

class NameReaderTest < TestCase
  
  test 'accepts an array' do
    reader = NameReader.new(%w{foo bar baz}).each
    assert_equal 'foo', reader.next
    assert_equal 'bar', reader.next
    assert_equal 'baz', reader.next
  end
  
  test 'accepts a file name' do # FIXME: This is not too nice
    class TestFile
      def self.read(filename)
        assert
        %w{foo bar baz}.collect{|el| el.gsub(' ', "\n")}.join('')
      end
    end
    reader = NameReader.new('whatever', TestFile)
  end
  
end