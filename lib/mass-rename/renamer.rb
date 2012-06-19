# encoding: utf-8

require 'fileutils'

module MassRename
  class Renamer
    
    attr_reader :renames
    
    def initialize(filenames, names)
      raise ArgumentError, "filenames and names can't have different element counts" unless filenames.length == names.length
      new_filenames = filenames.zip(names).collect{ |arr|
        if File.dirname(arr.first) != '.'
          File.join(File.dirname(arr.first), "#{arr.last}#{File.extname(arr.first)}")
        else
          "#{arr.last}#{File.extname(arr.first)}"
        end
      }
      @renames = Hash[filenames.zip(new_filenames)]
    end
    
    def rename!
      @renames.each do |filename, new_filename|
        FileUtils.mv filename, new_filename
      end
    end
    
  end
end