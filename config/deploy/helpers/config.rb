Ahshok::Deploy.with_configuration do

  namespace :config do

    task :setup, :except => { :no_release => true } do
      template = <<-EOF
      base: &base
        amazon_tag:    '#{amazon_tag}'
        amazon_key:    '#{amazon_key}'
        amazon_secret: '#{amazon_secret}'

      production:
        database_url:  'mysql://#{db_user}:#{db_pass}@#{db_server}/#{db_table}'
        <<: *base
      EOF
      config = ERB.new(template)

      run "mkdir -p #{shared_path}/config"
      put config.result(binding), "#{shared_path}/config/config.yml"
    end

    task :symlink, :except => { :no_release => true } do
      run "mv #{release_path}/config/config.yml #{release_path}/config/config.yml.bak"
      run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
    end

  end

  after 'deploy:setup', 'config:setup' unless fetch(:skip_config_setup, false)
  after 'deploy:finalize_update', 'config:symlink'

end
