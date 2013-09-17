Ahshok::Deploy.with_configuration do

  namespace :deploy do

    task :restart, :roles => :app, :except => { :no_release => true } do
      run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
    end

  end

end
