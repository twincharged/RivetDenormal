CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:                 'AWS',
    aws_access_key_id:        'AKIAJHWM2Z4RD4YWD2EA',
    aws_secret_access_key:    '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',
    region:                   'us-west-1',
    # host:                     'dev',
    # endpoint:                 'boltdev.s3-website-us-west-1.amazonaws.com'
  }
  config.fog_directory  = 'boltdev'
  # config.fog_host       = 'https://s3.amazonaws.com'
  config.fog_public     = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}



  if Rails.env == 'test'
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
end

# Mime.send(:remove_const, :JSON)
# Mime::Type.register "text/x-javascript", :json