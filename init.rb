require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'pry'
  gem 'rubyzip', '>= 1.0.0'
end

require 'zip'
require './get_aws_profile.rb'

###############################
# Get aws profile credentials #
###############################
begin
  aws_profile, aws_access_key_id, aws_secret_access_key = GetAwsProfile.call
rescue Errno::ENOENT => e
  abort("Make sure you have aws cli installed. Refer to https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html for more information.")
end


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
