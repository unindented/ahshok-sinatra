# Test tasks.

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/*_spec.rb'
end

# Migration tasks.

require File.expand_path('../config/builder', __FILE__)

namespace :db do

  desc 'Destructively migrates the datastore to match the model'
  task :migrate do
    # Parse the `config.ru` file to load dependencies.
    Builder::parse_development File.expand_path('../config.ru', __FILE__)
    # Migrate the datastore.
    DataMapper.auto_migrate!
  end

  desc 'Safely migrates the datastore to match the model'
  task :upgrade do
    # Parse the `config.ru` file to load dependencies.
    Builder::parse_development File.expand_path('../config.ru', __FILE__)
    # Migrate the datastore.
    DataMapper.auto_upgrade!
  end

end

# Default task.

task default: :test
