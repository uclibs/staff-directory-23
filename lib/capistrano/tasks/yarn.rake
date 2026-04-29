# frozen_string_literal: true

puts 'Loading Yarn tasks...'

namespace :yarn do
  desc 'Install node modules and build assets'
  task :build do
    on roles(:web) do
      within release_path do
        execute :echo, 'Running yarn install and yarn build via NVM'

        node_cmd = <<~BASH
          export NODE_OPTIONS=--openssl-legacy-provider && \
          source ~/.nvm/nvm.sh && \
          nvm use $(cat #{release_path}/.nvmrc) && \
          cd #{release_path} && \
          YARN_VERSION=$(ruby -rjson -e 'pm = JSON.parse(File.read("package.json"))["packageManager"]; abort("packageManager must start with yarn@") unless pm&.start_with?("yarn@"); puts pm.split("@", 2).last') && \
          corepack enable && \
          corepack prepare yarn@${YARN_VERSION} --activate && \
          corepack yarn install --immutable && \
          RAILS_ENV=production corepack yarn build
        BASH

        execute node_cmd
      end
    end
  end
end
