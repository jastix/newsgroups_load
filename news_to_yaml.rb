require 'rubygems'
require 'yaml'
require 'find'

class String
  def starts_with?(prefix)
  prefix = prefix.to_s
  self[0, prefix.length] == prefix
  end
end

def files_analysis
Find.find(Dir.pwd) do |file|
  if !File.directory?(file)
    f = File.open(file, "r")
    puts f.path
      f.each_line {|line|
        if line.starts_with?('From')
            address = line.split(':')
            puts address[1].to_s

          end
        }
  end

end

end # for def

categories = Dir.glob("**/").each {|x| x.chop!} #list of categories

Dir.chdir('test')

files_analysis

Dir.chdir('..')

Dir.chdir('train')

files_analysis

Dir.chdir('..')

