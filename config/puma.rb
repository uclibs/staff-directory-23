# frozen_string_literal: true

threads_count = ENV.fetch('RAILS_MAX_THREADS', 3)
threads threads_count, threads_count

# Use Unix socket instead of TCP port
bind 'unix:///opt/webapps/staff-directory/current/tmp/puma/puma.sock'

plugin :tmp_restart

pidfile ENV['PIDFILE'] if ENV['PIDFILE']
