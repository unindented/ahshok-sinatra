require 'bundler/capistrano'
require File.expand_path('../deploy/helpers', __FILE__)

# Options required for deployment on Dreamhost.
set :default_run_options, { :pty => false }
set :ssh_options, { :forward_agent => true }
set :use_sudo, false

# Application name.
set :application, 'ahshok'

# User and domain.
set(:user)   { Ahshok::Deploy.ask('User: ', 'unindented') }
set(:domain) { Ahshok::Deploy.ask('Domain: ', 'unindented.org') }

# Servers.
set(:app_server) { Ahshok::Deploy.ask('App server: ', "#{application}.#{domain}") }
set(:web_server) { Ahshok::Deploy.ask('Web server: ', "#{application}.#{domain}") }
set(:db_server)  { Ahshok::Deploy.ask('Database server: ', "mysql.#{domain}") }

# Amazon credentials.
set(:amazon_tag)    { Ahshok::Deploy.ask('Amazon tracking ID: ') }
set(:amazon_key)    { Ahshok::Deploy.ask('Amazon access key ID: ') }
set(:amazon_secret) { Ahshok::Deploy.psk('Amazon secret access key: ') }

# Database credentials.
set(:db_table) { Ahshok::Deploy.ask('Database table: ', application) }
set(:db_user)  { Ahshok::Deploy.ask('Database user: ', application) }
set(:db_pass)  { Ahshok::Deploy.psk('Database password: ') }

# Deploy path.
set(:deploy_to) { Ahshok::Deploy.ask('Deploy path: ', "/home/#{user}/#{app_server}") }

# Repository.
set :repository, 'git@github.com:unindented/ahshok-sinatra.git'
set :branch,     'dreamhost'

set :scm, :git
set :scm_verbose, true

# Roles.
role :app, app_server
role :web, web_server
role :db,  db_server, :no_release => true

# If you want to clean up old releases on each deploy uncomment this:
# after 'deploy:restart', 'deploy:cleanup'
