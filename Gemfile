# frozen_string_literal: true

# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.5'
gem 'activerecord-import'
# Reduces boot times through caching; required in config/boot.rb
# gem 'bootsnap', '>= 1.17.0', require: false
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.7'
# Use Puma as the app server
gem 'puma', '>= 6.3.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7', '>= 6.1.7.2'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'webpacker', '~> 5.0'

group :development do
  gem 'capistrano', '3.17.1'
  # gem 'capistrano3-puma', require: false
  gem 'capistrano-bundler', '~> 2.1', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rbenv', '~> 2.0' # required
  gem 'capistrano-rbenv-install', '~> 1.2.0'
  # gem 'capistrano-rvm', require: false
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rb-readline'
  gem 'rubocop'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.4'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 4.0', require: false
end

group :development, :production do
  gem 'mysql2'
end
