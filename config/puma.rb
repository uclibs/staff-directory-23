# frozen_string_literal: true

threads_count = ENV.fetch('RAILS_MAX_THREADS', 3)
threads threads_count, threads_count

plugin :tmp_restart

app_dir = File.expand_path('..', __dir__)

if ENV.fetch('RAILS_ENV', 'development') == 'production'
  directory app_dir.to_s
  bind "unix://#{app_dir}/tmp/puma/puma.sock"
  stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true
else
  port ENV.fetch('PORT', 3000)
end

pidfile "#{app_dir}/tmp/puma/pid"
state_path "#{app_dir}/tmp/puma/state"
activate_control_app
