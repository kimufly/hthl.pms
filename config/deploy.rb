require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/puma'

set :application_name, 'hthl.pms'
set :domain, '192.168.13.28'
set :deploy_to, '/var/www/pms.hthl-tech.com'
set :repository, 'git@gitlab.hthl-tech.com:linjingjing/hthl-pms.git'
set :branch, 'kimufly'
set :rails_env, 'development'

set :forward_agent, true

set :user, 'pms'
# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
set :shared_dirs, fetch(:shared_dirs, []).push('public/assets', 'tmp/sockets')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key', 'config/email.yml', 'config/puma.rb')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  invoke :'rvm:use', 'ruby-2.6.3@default'
end

# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0 --skip-existing}
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
        invoke :'puma:phased_restart'
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
