#!/usr/bin/env bash
set -euo pipefail

bundle config set path 'vendor/bundle'
bundle config set force_ruby_platform true
bundle install --jobs=4 --retry=3
DISABLE_SPRING=1 bundle exec rails db:migrate
