require 'rubygems'
require 'yaml'
require 'find'


class String
  def starts_with?(prefix)
  prefix = prefix.to_s
  self[0, prefix.length] == prefix
  end
end

@addresses = []
@subjects = []
@lines_array = []
@organizations = []
@messages  = []
@categories = []

#------categories--------------
cat = Dir.glob("**/").each {|x| x.chop! } #list of categories
cat.delete('train') if cat.include?('train')
cat.delete('test') if cat.include?('test')
cat.each {|tit| @categories << {"title" => "#{tit.split('/')[1]}"}}

#----parsing files---------
def files_analysis (train)


Find.find(Dir.pwd) do |file|
  if !File.directory?(file)
    f = File.open(file, "r")
    puts f.path
@organ = 0
message = []
      f.each_line {|line|
        if line.starts_with?('From')
          address = line.split(':')
          address.shift
          @addr = address.join.chomp[1..-1]

          if @addr == nil
            @addr = 'unknown'
          else @addr.include?('""')
            @addr.delete!('""')
          end
          if @addr.match(/[a-zA-Z]/) == nil
            @addr = 'unknown'

          end
puts @addr
#---------address---------

        elsif line.starts_with?('Subject')
          subject = line.split(':')
          subject.shift
          @subj = subject.join.chomp[1..-1]

          if @subj == nil
            @subj = 'unknown'
          else @subj.include?('""')
            @subj.delete!('""')
          end
          if @subj.match(/[a-zA-Z]/) == nil
            @subj = 'unknown'

          end

          @subjects << {"title" => "#{@subj}"}
#---------subject---------

        elsif line.starts_with?('Organization')
          @organ = 1
          organization = line.split(':')
          organization.shift
          @org = organization.join.chomp[1..-1]

          if @org == nil
            @org = 'unknown'
          else @org.include?('""')
            @org.delete!('""')
          end
          if @org.length < 3
            @org = 'unknown'
          end
          if @org.match(/[a-zA-Z]/) == nil
            @org = 'unknown'
          end

          @organizations << {"title" => "#{@org}"}
#---------organization---------
        @addresses << {"from" => "#{@addr}", "organization" => "#{@org}"}

        else


          message << line.chomp
          if f.eof?
            if @organ == 0
           @addresses << {"from" => "#{@addr}", "organization" => "unknown"}

        end
          @messages << {"body" => "#{message.join}", "train" => train, "address" => @addr, "category" => f.path.split('/').to_a[6], "subject" => @subj}
        end
       end

        }

  end
end



end #-- def --

Dir.chdir('test')
train = 0
files_analysis(train)

Dir.chdir('..')

Dir.chdir('train')
train = 1

files_analysis(train)

Dir.chdir('..')
puts "-------------"

  @addresses.uniq!
  @subjects.uniq!
  @organizations.uniq!
  @lines_array.uniq!
 puts @messages.length.to_s
  @categories.uniq!

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


File.open('messages.yml', 'w') do |out|
    mes = {"messages" => @messages}
    out.write(mes.to_yaml)
  end

File.open('categories.yml', 'w') do |out|
    cat = {"categories" => @categories}
    out.write(cat.to_yaml)
  end

