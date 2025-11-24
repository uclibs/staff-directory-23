# frozen_string_literal: true

set :application, 'staff-directory-23'
set :repo_url, 'https://github.com/uclibs/staff-directory-23.git'

set :rbenv_type, :user
set :rbenv_ruby, '3.3.3'
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all

# Set NODE_OPTIONS for all Capistrano-run commands
set :default_env, fetch(:default_env, {}).merge(
  'NODE_OPTIONS' => '--openssl-legacy-provider'
)

task :shared_db do
  on roles(:all) do
    execute "mkdir -p #{fetch(:deploy_to)}/shared/db/ && touch #{fetch(:deploy_to)}/shared/db/development.sqlite3"
    execute "mkdir -p #{fetch(:deploy_to)}/static"
    execute "cp #{fetch(:deploy_to)}/static/.env.development #{fetch(:release_path)}/ || true"
  end
end

task :init_local do
  on roles(:all) do
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
  desc 'Precompile assets'
  task :precompile_assets do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'assets:precompile'
        end
      end
    end
  end
end

after 'git:create_release', 'nvm:load'
after 'nvm:load', 'nvm:setup'
before 'deploy:starting', 'deploy:confirmation'
after 'deploy:updated', 'yarn:build'
after 'yarn:build', 'deploy:precompile_assets'
