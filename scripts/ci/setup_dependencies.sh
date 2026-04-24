#!/usr/bin/env bash
set -euo pipefail

ruby -v

if ! command -v bundle >/dev/null 2>&1; then
  gem install --user-install bundler
  export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
fi
bundle -v

bundle config set path 'vendor/bundle'
bundle config set force_ruby_platform true
bundle install --jobs=4 --retry=3

corepack enable

yarn_install_args=(--immutable)

if ! yarn install "${yarn_install_args[@]}"; then
  yarn cache clean --all || true
  rm -rf node_modules || true
  yarn install --check-cache "${yarn_install_args[@]}"
fi