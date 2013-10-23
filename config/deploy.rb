set :rails_env, ENV["RAILS_ENV"] || "production"
set :application, "freso-rails"
set :user, "ubuntu"
set :use_sudo, false
set :deploy_to, "/home/#{user}/#{application}"
set :scm, :git
set :repository, "git@github.com:joongimin/freso-rails.git"
set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false
set :unicorn_workers, 16

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :postgresql_database, 'freso'
set :postgresql_host, 'db1.fre.so'
set :branch, 'master'
server 'fre.so', :app, :web, :db, primary: true

require "bundler/capistrano"

load 'config/recipes/base'
load 'config/recipes/git'
load 'config/recipes/nginx'
load 'config/recipes/unicorn'
load 'config/recipes/rbenv'
load 'config/recipes/postgresql'

after 'deploy:update_code', 'deploy:migrate'