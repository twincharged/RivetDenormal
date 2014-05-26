CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider:                 'AWS',
    aws_access_key_id:        'key',
    aws_secret_access_key:    'secret_key',
    region:                   'us-west-2',
    host:                     'dev',
    endpoint:                 'dev'
  }
  config.fog_directory  = 'boltdev'
  # config.fog_host       = 'https://s3.amazonaws.com'
  config.fog_public     = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end