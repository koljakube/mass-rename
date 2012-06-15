# encoding: utf-8

require_relative 'test_helper'

class NumberStringGeneratorText < TestCase
  
  test 'generates numbers as strings in sequential order' do
    gen = NumberStringGenerator.new(1..3).each
    assert_equal '1', gen.next
    assert_equal '2', gen.next
    assert_equal '3', gen.next
  end
  
  test 'can be used with a block' do
    gen = NumberStringGenerator.new(1..3).each
    correct_num = 1
    gen.each do |num|
      assert_equal String(correct_num), num
      correct_num += 1
    end
    assert correct_num == 4
  end

  test 'generates numbers with a specified width and leads them with zeros' do
    gen = NumberStringGenerator.new(1..3, width: 3).each
    assert_equal '001', gen.next
    assert_equal '002', gen.next
    assert_equal '003', gen.next
  end

  test 'numbers can be filled with spaces' do
    gen = NumberStringGenerator.new(1..3, width: 3, lead_with_spaces: true).each
    assert_equal '  1', gen.next
    assert_equal '  2', gen.next
    assert_equal '  3', gen.next
  end
  
  test 'can start at arbitrary numbers' do
    gen = NumberStringGenerator.new(-1..1).each
    assert_equal '-1', gen.next
    assert_equal  '0', gen.next
    assert_equal  '1', gen.next
  end
    
end
