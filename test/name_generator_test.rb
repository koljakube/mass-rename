require_relative 'test_helper'

class NameGeneratorTest < TestCase
  
  setup do
    @names = %w{ foo bar } * 5 # count == 10
    @nsg = NumberStringGenerator.new(1..@names.count, width: NumberStringGenerator.needed_width(@names.count))
  end
  
  test 'default format is "fixed_width_number name"' do
    gen = NameGenerator.new(@names, @nsg).each
    assert_equal '01 foo', gen.next
    assert_equal '02 bar', gen.next
    assert_equal '03 foo', gen.next
  end
  
  test 'accepts prefixes, suffixes and both' do
    gen = NameGenerator.new(@names, @nsg, prefix: '1-').each
    assert_equal '1-01 foo', gen.next
    gen = NameGenerator.new(@names, @nsg, suffix: ' [2012]').each
    assert_equal '01 foo [2012]', gen.next
    gen = NameGenerator.new(@names, @nsg, prefix: '1-', suffix: ' [2012]').each
    assert_equal '1-01 foo [2012]', gen.next
  end
  
end
