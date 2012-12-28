namespace :redis do
  desc "Install the latest relase of Redis"
  task :install, roles: :app do
    run "#{sudo} add-apt-repository -y ppa:rwky/redis"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install redis-server"
  end
  after "deploy:install", "redis:install"
end
