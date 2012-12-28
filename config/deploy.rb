set :rails_env, ENV["RAILS_ENV"] || "production"
set :application, "freso"
set :user, "ubuntu"
set :use_sudo, false
set :deploy_to, "/home/#{user}/#{application}"
set :scm, :git
set :branch, "master"
set :repository,  "git@github.com:joongimin/freso-rails.git"
set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false
set :whenever_command, "bundle exec whenever"
set :maintenance_template_path, File.expand_path("../recipes/templates/maintenance.html.erb", __FILE__)
set :postgresql_user, "freso"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

if rails_env == "test"
  set :root_url, "d1.fre.so"
  server "d1.fre.so", :app, :web, :db, :primary => true
elsif rails_env == "development"
  set :root_url, "d3.fre.so"
  server "localhost", :app, :web, :db, :primary => true
else
  set :root_url, "fre.so"
  server "w1.fre.so", :app, :web, :db, :primary => true
end

require "bundler/capistrano"
require "whenever/capistrano"

load "config/recipes/base"
load "config/recipes/git"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/rbenv"
load "config/recipes/postgresql"
load "config/recipes/delayed_job"
load "config/recipes/redis"
load "deploy/assets"

after "deploy:update_code", "deploy:migrate"
after "deploy", "deploy:cleanup" # keep only the last 5 releases