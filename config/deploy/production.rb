# frozen_string_literal: true

set :rails_env, :production
set :bundle_without, %w[development test].join(' ')
set :branch, 'main'
set :default_env, path: '$PATH:/usr/local/bin'
set :bundle_path, -> { shared_path.join('vendor/bundle') }
set :rbenv_prefix,
    "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
append :linked_dirs, 'tmp', 'log'
ask(:username, nil)
ask(:password, nil, echo: false)
server 'libapps.libraries.uc.edu', user: fetch(:username), password: fetch(:password), port: 22, roles: %i[web app db]
ask(:value, 'Have you submitted and received an approved Change Management Request? (Y or Yes)')
unless fetch(:value).match?(/\A(?i:yes|y)\z/)
  # frozen_string_literal: true

  set :rails_env, :production
  set :bundle_without, %w[development test].join(' ')
  set :branch, 'main'
  set :default_env, path: '$PATH:/usr/local/bin'
  set :bundle_path, -> { shared_path.join('vendor/bundle') }
  set :rbenv_prefix,
      "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
  append :linked_dirs, 'tmp', 'log'
  ask(:username, nil)
  ask(:password, nil, echo: false)
  server 'libapps.libraries.uc.edu', user: fetch(:username), password: fetch(:password), port: 22, roles: %i[web app db]
  ask(:value, 'Have you submitted and received an approved Change Management Request? (Y or Yes)')
  unless fetch(:value).match?(/\A(?i:yes|y)\z/)
    puts "\nNo confirmation - deploy cancelled!"
    exit
  end
  set :deploy_to, '/opt/webapps/staff-directory'
  after 'deploy:updating', 'ruby_update_check'
  after 'deploy:updating', 'init_qp'
  before 'deploy:cleanup', 'start_qp'
  exit
end
set :deploy_to, '/opt/webapps/staff-directory'
after 'deploy:updating', 'ruby_update_check'
after 'deploy:updating', 'init_qp'
before 'deploy:cleanup', 'start_qp'
