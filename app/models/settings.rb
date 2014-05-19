class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

  secret_config_file = "#{Rails.root}/config/secrets.yml"
  if File.exist?(secret_config_file)
    instance.deep_merge!(Settings.new(secret_config_file))
  end

  local_config_file = "#{Rails.root}/config/application_local.yml"
  if File.exist?(local_config_file)
    instance.deep_merge!(Settings.new(local_config_file))
  end
end
