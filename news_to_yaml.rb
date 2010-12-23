require 'rubygems'
require 'yaml'
require 'find'
require 'ya2yaml'

class String
  def starts_with?(prefix)
  prefix = prefix.to_s
  self[0, prefix.length] == prefix
  end
end

def files_analysis
@addresses = []
@subjects = []
@lines_array = []
@organizations = []
@messages  = []
Find.find(Dir.pwd) do |file|
  if !File.directory?(file)
    f = File.open(file, "r")
    puts f.path
message = []
      f.each_line {|line|
        if line.starts_with?('From')
          address = line.split(':')
          address.shift
          puts address.join.chomp[1..-1]
          @addresses << {"from" => "#{address.join.chomp[1..-1]}" }

#---------address---------

        elsif line.starts_with?('Subject')
          subject = line.split(':')
          subject.shift
          puts subject.join.chomp[1..-1]
          @subjects << {"title" => "#{subject.join.chomp[1..-1]}"}
#---------subject---------
        elsif line.starts_with?('Lines')
          lines = line.split(':')
          lines.shift
          puts lines.join.chomp[1..-1]
          @lines_array << {"lines" => "#{lines.join.chomp[1..-1]}"}
#---------lines---------
        elsif line.starts_with?('Organization')
          organization = line.split(':')
          organization.shift
          puts organization.join.chomp[1..-1]
          @organizations << {"title" => "#{organization.join.chomp[1..-1]}"}
#---------organization---------
        else

          message << line.chomp
          message.to_yaml
          @messages << {"message" => "#{message.join}"} if f.eof?
       end

        }

  end




end

#puts subjects




end #-- def --
categories = Dir.glob("**/").each {|x| x.chop!} #list of categories

Dir.chdir('test')

files_analysis

Dir.chdir('..')

Dir.chdir('train')

files_analysis

Dir.chdir('..')
puts "-------------"

  @addresses.uniq!
  @subjects.uniq!
  @organizations.uniq!
  @lines_array.uniq!
  #@messages.uniq!

File.open('address.yml', 'w') do |out|
    addr = {"addresses" => @addresses}
    out.write(addr.to_yaml)
  end

File.open('subjects.yml', 'w') do |out|
    subj = {"subjects" => @subjects}
    out.write(subj.to_yaml)
  end


File.open('organizations.yml', 'w') do |out|
    org = {"organizations" => @organizations}
    out.write(org.to_yaml)
  end

File.open('lines_array.yml', 'w') do |out|
    la = {"lines_array" => @lines_array}
    out.write(la.to_yaml)
  end

File.open('messages.yml', 'w') do |out|
    mes = {"messages" => @messages}
    out.write(mes.ya2yaml)
  end

