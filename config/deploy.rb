set :rails_env, ENV["RAILS_ENV"] || "production"
set :application, "freso-rails"
set :user, 'ubuntu'
set :use_sudo, false
set :deploy_to, "/home/#{user}/#{application}"
set :scm, :git
set :repository, "git@github.com:joongimin/freso-rails.git"
set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false
set :whenever_command, "bundle exec whenever"
set :maintenance_template_path, File.expand_path("../recipes/templates/maintenance.html.erb", __FILE__)
set :unicorn_workers, 16
set :asset_host, "nm-as1.the-nuvo.com"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :postgresql_database, "nuvo_mc"
set :postgresql_host, "nm-db1.the-nuvo.com"
set :assets_prefix, "production_assets"
set :branch, "master"
server "fre.so", :app, :web, :db, :primary => true

require "bundler/capistrano"
require "capistrano/maintenance"

load "config/recipes/base"
load "config/recipes/git"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/rbenv"
load "config/recipes/postgresql"

after "deploy:update_code", "deploy:migrate"

task :copy_manifest do
  run "cp #{shared_path}/assets/#{rails_env}/manifest.yml #{shared_path}/assets/"
end
