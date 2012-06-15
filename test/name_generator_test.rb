require_relative 'test_helper'

class NameGeneratorTest < TestCase
  
  test 'default format is "fixed_width_number name"' do
    gen = NameGenerator.new %w{ foo bar } * 5 # count == 10
    assert_equal '01 foo', gen.generate
    assert_equal '02 bar', gen.generate
    assert_equal '03 foo', gen.generate
  end
  
end
