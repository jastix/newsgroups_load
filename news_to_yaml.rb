require 'rubygems'
require 'yaml'

class String
  def starts_with?(prefix)
  prefix = prefix.to_s
  self[0, prefix.length] == prefix
  end
end

email, name = Array.new

Dir.chdir('test')
categories = Dir.glob("**/").each {|x| x.chop!} #list of categories
Dir.glob("**/").each do |entry|
    Dir.open(entry) do |dir|
      dir.each do |file| #open every file in directory
        File.open(file.path, "r") do |line|
          if line.starts_with?('from')
            line.split

        puts file
      end
  end
end
Dir.chdir('..')


Dir.chdir('train')

