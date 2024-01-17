# frozen_string_literal: true

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

task :use_rbenv do
  require 'capistrano/rbenv'
  # require 'capistrano/rbenv_install'
end

task local: :use_rbenv
task qa: :use_rbenv
task production: :use_rbenv
