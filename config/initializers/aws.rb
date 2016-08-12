if ENV['S3_BUCKET_NAME']
  Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']).tap do |aws_credentials|
    Aws.config.update(
      {
        region: ENV['AWS_REGION'],
        credentials: aws_credentials
      })

    UploadTarget.bucket = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET_NAME'])

    Aws::Rails.add_action_mailer_delivery_method(:aws_ses, credentials: aws_credentials, region: ENV['AWS_REGION'])
  end
end
