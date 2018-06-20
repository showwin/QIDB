set :stage, :production
set :rails_env, 'production'
set :deploy_to, "/opt/rails/#{fetch(:application)}"
set :config_path, 'config'
set :unicorn_pid, -> { File.join(shared_path, 'tmp', 'pids', 'unicorn.pid') }
set :unicorn_config_path, 'config/unicorn.rb'
set :unicorn_rack_env, "#{fetch(:rails_env)}"
set :unicorn_restart_sleep_time, 3
server 'qidb-rails', user: 'rails', roles: %w(web app)
