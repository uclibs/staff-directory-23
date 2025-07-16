# frozen_string_literal: true

puts 'Loading Yarn tasks...'

namespace :yarn do
  desc 'Install node modules and build assets'
  task :build do
    on roles(:web) do
      within release_path do
        execute :echo, 'Running yarn install and yarn build via NVM'

        node_cmd = <<~BASH
          source ~/.nvm/nvm.sh && \
          nvm use $(cat #{release_path}/.nvmrc) && \
          cd #{release_path} && \
          yarn install --frozen-lockfile && \
          RAILS_ENV=production yarn build
        BASH

        execute node_cmd
      end
    end
  end
end
