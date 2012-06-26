#################################
## Exécute automatiquement bundle install --deployment --without development test 
## Commenté car pour une raison que je n'explique capistrano 
## ne reprends pas le path vers les gems (cap shell echo $PATH)
## Sous ssh ok. Testé avec path vers gems pour .bashrc, . bash_profile, .gemrc
################################
# require "bundler/capistrano"
# set :bundle_cmd, "/home/username/gems/bin/bundle"

#################################
## Info compte Alwaysdata
#################################
set :user, "username"
set :application, "nom_de_votre_application"
set :domain, "ssh.alwaysdata.com"
server domain, :app, :web
role :db, domain, :primary => true

########################################
## SCM (Git)
########################################
ssh_options[:forward_agent] = true
set :scm, :git
set :repository, "ssh://#{user}@ssh.alwaysdata.com/~/git/nom_de_votre_application.git"
set :branch, "rails3.0.3"
set :deploy_via, :remote_cache
# set :git_enable_submodules, 1
set :deploy_to, "/home/#{user}/chemin_vers_votre_application/#{application}"
set :keep_releases, 4
default_run_options[:pty] = true
set :use_sudo, false

########################################
## Tasks
########################################
after 'deploy:update_code' do

  run <<-CMD
    ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml
  CMD
  %w(sitemap.xml robots.txt).each do |file|
    run <<-CMD
      ln -nfs #{shared_path}/public/#{file} #{release_path}/public/#{file}
    CMD
  end
  
  # Solution d'attente pour bundle install. 
  # Contourne le pb du path non reconnu par capistrano lors du deploy
  run <<-CMD 
    cd #{release_path} && /home/username/gems/bin/bundle install --deployment --without development test
  CMD
end
# Supprime les anciennes version (:keep_releases)
after "deploy", "deploy:cleanup"

########################################
## Passenger
########################################
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end