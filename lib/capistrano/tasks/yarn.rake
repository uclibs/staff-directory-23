# frozen_string_literal: true

puts 'Loading Yarn tasks...'

namespace :yarn do
  desc 'Install node modules and build assets'
  task :build do
    on roles(:web) do
      within release_path do
        execute :echo, 'Running yarn install and yarn build via NVM'

        node_cmd = <<~BASH
          set -eu
          export NODE_OPTIONS=--openssl-legacy-provider
          source ~/.nvm/nvm.sh
          nvm use "$(cat #{release_path}/.nvmrc)"
          cd #{release_path}
          # Node 25+ no longer ships Corepack; Yarn 4 still comes through it.
          if ! command -v corepack >/dev/null 2>&1; then
            npm install -g corepack
          fi
          export COREPACK_ENABLE_DOWNLOAD_PROMPT=0
          corepack enable
          corepack yarn install --immutable
          RAILS_ENV=production corepack yarn build
        BASH

        execute node_cmd
      end
    end
  end
end
