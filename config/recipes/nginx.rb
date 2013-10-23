namespace :nginx do
  desc "Install latest stable release of nginx"
  task :install, :roles => :web do
    run "#{sudo} add-apt-repository -y ppa:nginx/stable"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install nginx"
  end
  after "deploy:install", "nginx:install"

  desc "Setup nginx configuration for this application"
  task :setup, :roles => :web do
    run "#{sudo} rm -f /etc/nginx/sites-enabled/default"
    roles[:web].servers.each do |server|
      set :server_host, server
      if rails_env == "test"
        template "nginx_unicorn_test.erb", "/etc/nginx/sites-enabled/#{application}", :use_temp_file => true
      else
        template "nginx_unicorn.erb", "/etc/nginx/sites-enabled/#{application}", :use_temp_file => true
      end
    end
  end
  after "deploy:setup", "nginx:setup"

  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command, :roles => :web do
      run "#{sudo} service unicorn_#{application} #{command}"
    end
  end
end