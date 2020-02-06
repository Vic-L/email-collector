require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'pry'
  gem 'rubyzip', '>= 1.0.0'
end

require 'zip'

###############################
# Get aws profile credentials #
###############################
aws_profile = "TODO"

begin
  aws_access_key_id = `aws --profile #{aws_profile} configure get aws_access_key_id`.chomp
  abort('') if aws_access_key_id.empty?

  aws_secret_access_key = `aws --profile #{aws_profile} configure get aws_secret_access_key`.chomp
  abort('') if aws_secret_access_key.empty?
rescue Errno::ENOENT => e
  abort("Make sure you have aws cli installed. Refer to https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html for more information.")
end

p "AWS_ACCESS_KEY_ID = #{aws_access_key_id}"
p "AWS_SECRET_ACCESS_KEY = #{aws_secret_access_key}"

#################
# zip code file #
#################

folder = Dir.pwd
input_filenames = ['index.js']
zipfile_name = File.join(Dir.pwd, 'TODO.zip')

Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
  input_filenames.each do |filename|
    zipfile.add(filename, File.join(folder, filename))
  end
end



File.delete(zipfile_name) if File.exist?(zipfile_name)
