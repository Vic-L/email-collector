require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'pry'
  gem 'aws-sdk-s3', '~> 1'
end

require './get_aws_profile.rb'

###############################
# Get aws profile credentials #
###############################

aws_profile, aws_access_key_id, aws_secret_access_key = GetAwsProfile.call

####################
# create s3 bucket #
####################

s3_client = Aws::S3::Client.new(
  access_key_id: aws_access_key_id,
  secret_access_key: aws_secret_access_key,
  region: 'eu-west-1'
)

s3_client.create_bucket(
  bucket: 'todo-project-tfstate',
  create_bucket_configuration: {
    location_constraint: 'eu-west-1'
  }
)

end

`docker run \
  --rm \
  --env AWS_ACCESS_KEY_ID=#{aws_access_key_id} \
  --env AWS_SECRET_ACCESS_KEY=#{aws_secret_access_key} \
  -v $(pwd):/workspace \
  -w /workspace \
  -it \
  hashicorp/terraform:0.12.12 \
  init`

