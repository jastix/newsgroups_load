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
          address.shift
          puts address.join.chomp[1..-1]
#---------address---------

        elsif line.starts_with?('Subject')
          subject = line.split(':')
          subject.shift
          puts subject.join.chomp[1..-1]
#---------subject---------
        elsif line.starts_with?('Lines')
          lines = line.split(':')
          lines.shift
          puts lines.join.chomp[1..-1]
#---------lines---------
        elsif line.starts_with?('Organization')
          organization = line.split(':')
          organization.shift
          puts organization.join.chomp[1..-1]
#---------organization---------
       else
        message = []
        message << line
        puts message.join
       end
        }
  end

end

end
categories = Dir.glob("**/").each {|x| x.chop!} #list of categories

Dir.chdir('test')

files_analysis

Dir.chdir('..')

Dir.chdir('train')

files_analysis

Dir.chdir('..')

