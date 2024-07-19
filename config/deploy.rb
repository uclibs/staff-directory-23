lock '~> 3.18.1'

set :application, 'staff-directory-23'
set :repo_url, 'https://github.com/uclibs/staff-directory-23.git'

set :rbenv_type, :user
set :rbenv_ruby, '3.3.3'
# set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all # default value

task :shared_db do
  on roles(:all) do
    execute "mkdir -p #{fetch(:deploy_to)}/shared/db/ && touch #{fetch(:deploy_to)}/shared/db/development.sqlite3"
    execute "mkdir -p #{fetch(:deploy_to)}/static"
    execute "cp #{fetch(:deploy_to)}/static/.env.development #{fetch(:release_path)}/ || true"
  end
end

task :init_local do
  on roles(:all) do
    # execute "pwd"
    # execute "cd #{fetch(:release_path)} && gem install bundler -v $(tail -n1 Gemfile.lock)"
    execute "bundle config path 'vendor/bundle' --local"
  end
end

task :start_local do
  on roles(:all) do
    execute "export PATH=$PATH:/usr/local/bin && cd #{fetch(:release_path)}/scripts && source start_local.sh"
    execute "mkdir -p #{fetch(:deploy_to)}/static"
  end
end

task :init_qp do
  on roles(:all) do
    execute "gem install bundler -v $(tail -n1 #{fetch(:release_path)}/Gemfile.lock)"
    execute "bundle config path 'vendor/bundle' --local"
    execute "mkdir -p #{fetch(:deploy_to)}/static"
    execute "cp #{fetch(:deploy_to)}/static/.env.production.local #{fetch(:release_path)}/ || true"
  end
end

task :start_qp do
  on roles(:all) do
    execute "cd #{fetch(:release_path)}/ && chmod a+x scripts/* && source scripts/start_qp.sh"
  end
end

task :ruby_update_check do
  on roles(:all) do
    execute "cd #{fetch(:release_path)}/ && chmod a+x scripts/* && source scripts/check_ruby.sh"
  end
end

namespace :deploy do
  task :confirmation do
    stage = fetch(:stage).upcase
    branch = fetch(:branch)
    puts <<-WARN

    ========================================================================

      *** Deploying branch `#{branch}` to #{stage} server ***

      WARNING: You're about to perform actions on #{stage} server(s)
      Please confirm that all your intentions are kind and friendly

    ========================================================================

    WARN
    ask :value, "Sure you want to continue deploying `#{branch}` on #{stage}? (Y or Yes)"

    unless fetch(:value).match?(/\A(?i:yes|y)\z/)
      puts "\nNo confirmation - deploy cancelled!"
      exit
    end
  end
end

Capistrano::DSL.stages.each do |stage|
  after stage, 'deploy:confirmation'
end
