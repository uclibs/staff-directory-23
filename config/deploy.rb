set :application, 'staff-directory-23'
set :repo_url, 'https://github.com/uclibs/staff-directory-23.git'

set :rbenv_type, :user
set :rbenv_ruby, '3.3.3'
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all

# Helper to wrap commands in an `nvm` context, even if .nvmrc is missing
def with_nvm(command)
  <<~BASH
    echo "PWD before NVM: $(pwd)"
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    if [ -f .nvmrc ]; then \
      NVM_VERSION=$(cat .nvmrc | tr -d ' \\n\\r'); \
      nvm install "$NVM_VERSION" && nvm use "$NVM_VERSION"; \
    else \
      nvm install 18.17.1 && nvm use 18.17.1; \
    fi && \
    echo "PWD after NVM: $(pwd)" && \
    #{command}
  BASH
end

# Custom asset compilation to ensure nvm is used
Rake::Task['deploy:assets:precompile'].clear_actions

namespace :deploy do
  namespace :assets do
    task :precompile do
      on roles(:web) do
        within release_path do
          execute with_nvm('yarn install')
          execute with_nvm('RAILS_ENV=production bundle exec rails assets:precompile')
        end
      end
    end
  end
end

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
