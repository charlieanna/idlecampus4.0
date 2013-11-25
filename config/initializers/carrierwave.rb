CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAIYN632RX35RGIUKQ',                        # required
    :aws_secret_access_key  => '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',                        # required
   
  }
  config.fog_directory  = 'idlecampus1'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  # config.s3_access_policy = :public_read     
end

