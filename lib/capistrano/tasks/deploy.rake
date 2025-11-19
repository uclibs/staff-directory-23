# frozen_string_literal: true

namespace :deploy do
  task :confirmation do
    stage = fetch(:stage).upcase
    branch = fetch(:branch)
    puts <<-WARN

    ========================================================================

      *** Deploying branch `#{branch}` to #{stage} server ***

      WARNING: You're about to perform actions on #{stage} server(s)
      Please confirm that all your intentions are kind and friendly

    ========================================================================

    WARN
    ask :value, "Sure you want to continue deploying `#{branch}` on #{stage}? (Y or Yes)"

    unless fetch(:value).match?(/\A(?i:yes|y)\z/)
      puts "\nNo confirmation - deploy cancelled!"
      exit
    end
  end
end
