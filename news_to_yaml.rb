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
    Dir.chdir(entry)
    puts Dir.pwd
    Dir.entries(Dir.pwd).each {|file|
         #open every file in directory

        f = File.open(file, "r") unless !File.directory?(file)
        f.each_line {|line|
        puts line
          if line.starts_with?('from')
            line.split


        end
        }}

      end
  end
  Dir.chdir('..')
end
Dir.chdir('..')


Dir.chdir('train')

