CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws'
  # config.fog_credentials = {
  #     aws_access_key_id: Rails.application.credentials.aws[:aws_akid],
  #     aws_secret_access_key: Rails.application.credentials.aws[:aws_sak],
  #     provider: 'AWS',
  #     region: 'eu-central-1' # ,
  #     # use_iam_profile:       true,
  #     # host:                  's3.example.com',
  #     # endpoint:              'http://localhost:3000'
  # }
  # config.fog_directory  = 'gallery-starting-bucket'
  # config.fog_public     = false
  # config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
end
