ENV['RAILS_ENV'] || 'production'

app_path = "/opt/rails/QIDB"
app_shared_path = "#{app_path}/shared"

# number of workers
worker_processes 4

# 実態は symlink。
# SIGUSR2 を送った時にこの symlink に対して
# Unicorn のインスタンスが立ち上がる
working_directory "#{app_path}/current/"

# socket or port
listen '/tmp/unicorn.sock'

# log
stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])

pid "#{app_shared_path}/tmp/pids/unicorn.pid"

before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

# prevent downtime
preload_app true
timeout 300

before_fork do |server, _|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  unless old_pid == server.pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    end
  end
end

after_fork do |_, _|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
