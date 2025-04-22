# frozen_string_literal: true

# Pin concurrent-ruby to 1.3.4 due to bug in later versions leading to "Logger::Severity" error.

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.3'
gem 'actionpack', '6.1.7.10'
gem 'activerecord-import'
# Reduces boot times through caching; required in config/boot.rb
# gem 'bootsnap', '>= 1.17.0', require: false
# #added for ruby 3.4.0 as its not in standard library anymore
gem 'bigdecimal'
gem 'bootsnap', '>= 1.1.0', require: false
# added for ruby 3.4.0 as its not in standard library anymore
gem 'concurrent-ruby', '1.3.4'
gem 'csv'
gem 'devise'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.7'
# Use Puma as the app server
gem 'nokogiri', '1.18.8' # Pin because servers lack needed GLIBC version
gem 'puma', '>= 6.3.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '>= 6.1.7.7', '< 6.2'
gem 'rails-html-sanitizer', '1.6.0'
gem 'rexml', '>= 3.3.2'
gem 'sass-rails', '>= 6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'webpacker', '~> 5.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# gem 'coveralls', '~> 0.8.22', require: false
gem 'coveralls_reborn'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

group :development do
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'capistrano', '~> 3.19'
  # gem 'capistrano3-puma', require: false
  gem 'capistrano-bundler', '~> 2.1', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rbenv', '~> 2.0' # required
  gem 'capistrano-rbenv-install', '~> 1.2.0'
  # gem 'capistrano-rvm', require: false
  gem 'ed25519', '>= 1.2', '< 2.0'
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
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 4.0', require: false
end

group :development, :production do
  gem 'mysql2', '~> 0.5.6'
end
