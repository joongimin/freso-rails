CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/"
  config.storage = :fog
  config.permissions = 0666
  config.fog_credentials = {
    :provider               => "AWS",
    :aws_access_key_id      => Settings.aws_access_key_id,
    :aws_secret_access_key  => Settings.aws_secret_access_key,
  }

  config.fog_directory = "freso-images"
  config.fog_attributes = {"Cache-Control" => "max-age=315576000"}
  config.asset_host = Settings.asset_base_url
end