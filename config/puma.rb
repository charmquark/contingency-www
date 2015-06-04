#!/usr/bin/env puma

rails_env = ENV['RAILS_ENV'] || 'development'
rackup DefaultRackup

environment rails_env
stdout_redirect "log/#{ rails_env }.log", "log/#{ rails_env }_err.log"

#eval File.read("config/puma/#{ rails_env }.rb")

case rails_env
when 'development'
    port 3000
when 'staging'
    bind 'unix:///var/run/puma/contingency-staging.sock'
    pidfile 'tmp/pids/puma.pid'
    state_path 'tmp/pids/puma.state'
    daemonize
    quiet
when 'production'
    bind 'unix:///var/run/puma/contingency.sock'
    pidfile 'tmp/pids/puma.pid'
    state_path 'tmp/pids/puma.state'
    daemonize
    quiet
end

