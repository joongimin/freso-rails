set_default(:postgresql_host, "localhost")
set_default(:postgresql_user) { "nuvo" }
set_default(:postgresql_root_password) { "welcome2nv" }
set_default(:postgresql_password) { "welcome2nv" }
set_default(:postgresql_production_database) { "freso" }
set_default(:postgresql_production_host) { "db1.fre.so" }


namespace :postgresql do
  desc "Install latest stable release of postgresql"
  task :install, roles: :db, only: {primary: true} do
    run "#{sudo} add-apt-repository ppa:pitti/postgresql", pty: true do |ch, stream, data|
      press_enter( ch, stream, data)
    end

    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install postgresql libpq-dev"
  end
  after "deploy:install", "postgresql:install"

  desc "Generate the database.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
    run "mkdir -p #{shared_path}/backups"
  end
  after "deploy:setup", "postgresql:setup"

  desc "Backup PostgreSQL Database"
  task :backup, roles: :db do
    run "pg_dump -U#{postgresql_user} #{postgresql_database} -h #{postgresql_host} --clean > #{shared_path}/backups/#{release_name}.sql"
  end
  before "deploy:migrate", "postgresql:backup"
end