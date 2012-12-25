set :output, File.join(Whenever.path, "log", "whenever.log")

every :reboot do
  command "#{Whenever.path}/script/delayed_job start"
end