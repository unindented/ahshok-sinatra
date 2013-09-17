source 'https://rubygems.org'

gem 'rake', '>= 0.8.7'

gem 'unicorn', '~> 4.8.3'
gem 'sinatra', '~> 1.4.5', require: 'sinatra/base'
gem 'sinatra-contrib', '~> 1.4.2', require: 'sinatra/reloader'

gem 'nokogiri', '~> 1.6.3'
gem 'vacuum', '~> 1.1.1'
gem 'data_mapper', '~> 1.2.0'

group :production do
  gem 'dm-postgres-adapter', '~> 1.2.0'
end

group :test, :development do
  gem 'dm-sqlite-adapter', '~> 1.2.0'
end

group :test do
  gem 'rack-test', '~> 0.6.2', require: 'rack/test'
  gem 'minitest', '~> 5.4.1', require: 'minitest/autorun'

  gem 'webmock', '~> 1.18.0'
  gem 'vcr', '~> 2.9.2'
end

group :development do
  gem 'foreman'
  gem 'pry'

  gem 'capistrano', '~> 2.15.5'
end
