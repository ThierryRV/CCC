# deploy.rb
require 'bundler/capistrano'
set :bundle_cmd, "/home/ccc/gems/bin/bundle"

server "ssh.alwaysdata.com", :web, :app, :db, primary: true

set :user, "ccc"
set :application_folder, "ccc"
set :git_repository, "CCC"
set :git_user, "ThierryRV"
set :deploy_to, "/home/#{user}/#{application_folder}"
set :rails_env, "production"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:#{git_user}/#{git_repository}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :keep_releases, 4
set :git_enable_submodules, 1

after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

