# config valid only for current version of Capistrano
lock '3.4.0'

set :rails_env, fetch(:stage)

set :application, 'contingency'
set :repo_url, 'git@github.com:csauls/contingency-www.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/http/invironz.com/contingency-staging'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# RVM settings
set :rvm_type, :auto
set :rvm_ruby_version, '2.0.0'

namespace :deploy do
    
    after :started, 'app:stop' do
        on roles(:app) do |host|
            within release_path do
                with rails_env: fetch(:rails_env) do
                    execute :rake, 'app:stop'
                end
            end
        end
    end
    
    after 'git:create_release', 'app:dotenv' do
        on roles(:app) do |host|
            env_file = ".env.#{fetch :rails_env}"
            execute "cp #{deploy_path}/#{env_file} #{release_path}/#{env_file}"
        end
    end
    
    after :published, 'app:start' do
        on roles(:app) do |host|
            within release_path do
                with rails_env: fetch(:rails_env) do
                    execute :rake, 'app:start'
                end
            end
        end
    end

#     after :restart, :clear_cache do
#         on roles(:web), in: :groups, limit: 3, wait: 10 do
#             # Here we can do anything such as:
#             # within release_path do
#             #   execute :rake, 'cache:clear'
#             # end
#         end
#     end

end
