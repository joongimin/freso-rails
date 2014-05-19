set :application, 'freso-rails'
set :user, 'ubuntu'
set :github, 'joongimin/freso-rails'
set :repo_url, "git@github.com:#{fetch(:github)}.git"
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :ssh_options, {forward_agent: true}
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system backups}
set :rbenv_ruby, '2.1.1'
set :unicorn_workers, 16
set :format, :notification
set :notify_from, 'Crema <crema@the-nuvo.com>'
set :notify_to, 'crema@the-nuvo.com'
set :unicorn_port, 8000
set :secrets, Settingslogic.new('config/secrets.yml')

# in RAILS_ROOT/config/deploy.rb:

namespace :deploy do
  desc 'Symlinks the linked_files'
  before :check, :symlink_templates do
    on roles(:app) do
      upload! StringIO.new(ERB.new(File.read(File.join(File.dirname(__FILE__), "deploy/templates/database.yml"))).result(binding)), "#{shared_path}/config/database.yml"
      upload! File.join(File.dirname(__FILE__), "../config/secrets.yml"), "#{shared_path}/config/secrets.yml"
    end
  end
end

after 'deploy:publishing', 'deploy:restart'
