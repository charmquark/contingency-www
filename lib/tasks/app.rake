
namespace :app do

    PUMA_CONFIG_FILE    = 'config/puma.rb'
    PUMA_PID_FILE       = 'tmp/pids/puma.pid'
    PUMA_STATE_FILE     = 'tmp/pids/puma.state'


    def invoke (id)
        Rake::Task[id].invoke
    end

    def puma_running?
        File.exist? PUMA_PID_FILE
    end


    invoke 'dotenv'
    rails_env = ENV['RAILS_ENV'] || 'development'


    desc 'start application'
    task :start => :dotenv do
        unless puma_running?
            invoke 'tmp:create'
            #if rails_env != 'development'
            #    invoke 'assets:environment'
            #    invoke 'assets:precompile'
            #end
            invoke 'log:clear'
            sh "bundle exec puma -C #{ PUMA_CONFIG_FILE }"
        else
            puts 'The application appears to already be running (pid file present).'
        end
    end

    desc 'stop application'
    task :stop => :dotenv do
        if puma_running?
            sh "kill -TERM `cat #{ PUMA_PID_FILE }`"
        end
    end

#     desc 'update and restart application'
#     task :update do
#         was_running = puma_running?
#         invoke 'app:stop' if was_running
#         sh 'git pull'
#         %w(assets:clobber tmp:clear db:migrate).each {|x| invoke x }
#         invoke 'app:start' if was_running
#     end

end

