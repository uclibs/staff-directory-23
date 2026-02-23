# frozen_string_literal: true

# Pin concurrent-ruby to 1.3.4 due to bug in later versions leading to "Logger::Severity" error.

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.expand_path('.ruby-version', __dir__)).strip
gem 'activerecord-import'
# Reduces boot times through caching; required in config/boot.rb
gem 'bigdecimal'
gem 'bootsnap', '>= 1.1.0', require: false
# added for ruby 3.4.0 as its not in standard library anymore
gem 'concurrent-ruby', '1.3.4'
gem 'csv'
gem 'devise'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.7'
gem 'nokogiri', '~> 1.19.1'
gem 'puma', '>= 6.3.1'
gem 'rails', '~> 8.1', '>= 8.1.2'
gem 'rails-html-sanitizer', '~>1.6'
gem 'rexml', '>= 3.3.2'
gem 'sass-rails', '>= 6'
gem 'sprockets-rails' # required for sass-rails on Rails 8 (Propshaft is default)
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'shakapacker', '9.5.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
gem 'coveralls_reborn'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

group :development do
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'capistrano', '~> 3.19'
  gem 'capistrano-bundler', '~> 2.1', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rbenv', '~> 2.0' # required
  gem 'capistrano-rbenv-install', '~> 1.2.0'
  gem 'ed25519', '>= 1.2', '< 2.0'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '>= 3.3.0'
  gem 'rb-readline'
  gem 'rdoc', '7.2.0', require: false # Pin to match Ruby 3.4 default gem and avoid duplicate RDoc constant warnings
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
  gem 'rubocop', '1.84.1', require: false
  gem 'rubocop-capybara', '2.22.1', require: false
  gem 'rubocop-factory_bot', '2.28.0', require: false
  gem 'rubocop-rails', '2.34.3', require: false
  gem 'rubocop-rspec', '3.9.0', require: false
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '>= 2.1' # Rails 8.1 requires sqlite3 >= 2.1
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
