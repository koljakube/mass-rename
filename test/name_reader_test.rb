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
        %w{foo bar baz}.join("\n")
      end
    end
    reader = NameReader.new('whatever', TestFile).each
    assert 'foo', reader.next
    assert 'bar', reader.next
    assert 'baz', reader.next
  end
  
end