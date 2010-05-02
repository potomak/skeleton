# be sure to change these
set :user, 'giovanni'
set :domain, 'focustheweb.com'
set :application, 'skeleton'

# file paths
set :repository, "git@github.com:potomak/skeleton.git"
set :deploy_to, "/var/vhosts/#{domain}/#{application}"

# distribute your applications across servers (the instructions below put them
# all on the same server, defined above as 'domain', adjust as necessary)
role :app, domain
role :web, domain
role :db, domain, :primary => true

#set :deploy_via, :remote_cache
set :deploy_via, :export
set :scm, :git
set :branch, 'master'
set :scm_verbose, true
set :ssh_options, {:forward_agent => true}
set :use_sudo, false

# task which causes Passenger to initiate a restart
namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

# optional task to reconfigure databases
after "deploy:update_code", :configure_database
desc "copy database.yml into the current release path"
task :configure_database, :roles => :app do
  db_config = "#{deploy_to}/config/database.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
end

after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"