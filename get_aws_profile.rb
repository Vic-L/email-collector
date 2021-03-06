###############################
# Get aws profile credentials #
###############################

class GetAwsProfile
  def self.call
    aws_profile = "todo-aws_profile"

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

    [aws_profile, aws_access_key_id, aws_secret_access_key]
  end
end
