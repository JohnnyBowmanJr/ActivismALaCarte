require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAIZAMZGDXD665MAAA',
    :aws_secret_access_key  => '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',
    :region                 => 'us-east-1'
  }
  config.fog_directory  = 'ActivistCampaignImage'
  # config.fog_host       = 'https://s3.amazonaws.com'
  config.fog_public     = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end