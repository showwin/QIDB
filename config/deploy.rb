# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'QIDB'
set :repo_url, 'git@github.com:showwin/QIDB.git'

set :branch, ENV['BRANCH'] || 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/opt/rails/QIDB'

# Default value for :scm is :git
set :scm, :git

# Default value for :log_level is :debug
set :log_level, :debug

# rbenv configs
set :rbenv_type, :user
set :rbenv_ruby, '2.4.6'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :bundle_binstubs, -> { shared_path.join('bin') }

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  task :start do
    invoke 'unicorn:start'
  end

  task :stop do
    invoke 'unicorn:stop'
  end

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :restart, :clear_cache do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'
end
