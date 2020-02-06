require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'pry'
  gem 'rubyzip', '>= 1.0.0'
end

require './get_aws_profile.rb'
require 'zip'

aws_profile, aws_access_key_id, aws_secret_access_key = GetAwsProfile.call

#################
# zip code file #
#################

folder = Dir.pwd
input_filenames = ['index.js']
zipfile_name = File.join(Dir.pwd, 'todo-project.zip')

File.delete(zipfile_name) if File.exist?(zipfile_name)

Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
  input_filenames.each do |filename|
    zipfile.add(filename, File.join(folder, filename))
  end
end

response = `docker run \
  --rm \
  --env AWS_ACCESS_KEY_ID=#{aws_access_key_id} \
  --env AWS_SECRET_ACCESS_KEY=#{aws_secret_access_key} \
  -v #{Dir.pwd}:/workspace \
  -w /workspace \
  -it \
  hashicorp/terraform:0.12.12 \
  apply -auto-approve`

puts response

File.delete(zipfile_name) if File.exist?(zipfile_name)
