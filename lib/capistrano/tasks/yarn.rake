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

          package_manager="$(node -p "require('./package.json').packageManager")"
          yarn_version="${package_manager#yarn@}"
          if [ "$yarn_version" = "$package_manager" ]; then
            echo "packageManager must start with yarn@ (got: $package_manager)" >&2
            exit 1
          fi

          corepack enable
          corepack prepare "yarn@${yarn_version}" --activate
          corepack yarn install --immutable
          RAILS_ENV=production corepack yarn build
        BASH

        execute node_cmd
      end
    end
  end
end
