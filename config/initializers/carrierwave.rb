CarrierWave.configure do |config|
  unless Rails.env.development? || Rails.env.test?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV["AWS_S3_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_S3_SECRET_ACCESS_KEY"],
      region: 'ap-northeast-1'
    }
    config.storage = :fog
    config.fog_directory = ENV["AWS_S3_BUCKET_NAME"]
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/