# encoding: utf-8

require_relative 'test_helper'

class NumberStringGeneratorText < TestCase
  
  test 'generates numbers as strings in sequential order' do
    gen = NumberStringGenerator.new
    assert_equal '1', gen.next_number
    assert_equal '2', gen.next_number
    assert_equal '3', gen.next_number
  end
  
  test 'accepts a range' do
    gen = NumberStringGenerator.new range: 1..3
    assert_equal '1', gen.next_number
    assert_equal '2', gen.next_number
    assert_equal '3', gen.next_number
    assert_equal nil, gen.next_number
  end
  
  test 'can be used as a block when a range is given' do
    gen = NumberStringGenerator.new range: 1..3
    correct_num = 1
    gen.all_numbers do |num|
      assert_equal String(correct_num), num
      correct_num += 1
    end
    assert correct_num == 4
  end

  test 'generates numbers with a specified width and leads them with zeros' do
    gen = NumberStringGenerator.new width: 3
    assert_equal '001', gen.next_number
    assert_equal '002', gen.next_number
    assert_equal '003', gen.next_number
  end

  test 'numbers can be filled with spaces' do
    gen = NumberStringGenerator.new width: 3, lead_with_spaces: true
    assert_equal '  1', gen.next_number
    assert_equal '  2', gen.next_number
    assert_equal '  3', gen.next_number
  end
  
  test 'can start at arbitrary numbers' do
    gen = NumberStringGenerator.new range: -1..1
    assert_equal '-1', gen.next_number
    assert_equal  '0', gen.next_number
    assert_equal  '1', gen.next_number
  end
    
end
