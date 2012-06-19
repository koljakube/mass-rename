# encoding: utf-8

require_relative 'test_helper'

class RenamerTest < TestCase
  
  test 'correctly handles valid input' do
    renames = {
      's01e01.foo.m4v' => '1-01 Foo.m4v',
      's01e02.bar.avi' => '1-02 Bar.avi', 
    }
    renamer = Renamer.new(renames.keys, renames.values.collect{|val| val[0..-5]})
    assert_equal renames, renamer.renames
  end
  
  test 'does not accept a different amount of files and names' do
    assert_raises ArgumentError do
      Renamer.new(%{foo}, %{foo bar})
    end
  end
  
  test 'correctly handles paths' do
    renames = {
      'some/directory/s01e01.foo.m4v' => 'some/directory/1-01 Foo.m4v',
      'some/directory/s01e02.bar.avi' => 'some/directory/1-02 Bar.avi', 
    }
    renamer = Renamer.new(renames.keys, renames.values.collect{|val| val.gsub(/.*\//, '')[0..-5]})
    assert_equal renames, renamer.renames
  end
  
end
