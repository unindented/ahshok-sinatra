require File.expand_path('../libraries', __FILE__)

module Ahshok
  class App < Sinatra::Base

    register Ahshok::Extensions::ConfigLoader
    helpers  Ahshok::Extensions::ProductHelper

    # Configure reloading.
    configure do
      register Sinatra::Reloader if development?
    end

    # Configure logging.
    configure do
      STDOUT.sync = true
      enable :logging unless test?
    end

    # Load config file.
    configure do
      load_config(File.join(root, '../config/config.yml'))
    end

    # Configure DataMapper.
    configure do
      # Setup the database.
      DataMapper.setup :default, ENV['DATABASE_URL']
      DataMapper.finalize
      DataMapper.auto_upgrade!
      # Raise errors on save failures.
      DataMapper::Model.raise_on_save_failure = true
    end

    # Configure Vacuum.
    configure do
      # Instantiate with credentials.
      vacuum = Vacuum.new.configure({
        associate_tag:         ENV['AMAZON_TAG'],
        aws_access_key_id:     ENV['AMAZON_KEY'],
        aws_secret_access_key: ENV['AMAZON_SECRET']
      })
      # Store the reference.
      set :vacuum, vacuum
    end

    # Product URL.
    get %r{^/([0-9A-Z]{10})$} do |asin|
      product = find_or_create_product asin
      halt 404 if product.link.nil?
      redirect product.link.to_s, 301
    end

    # Image URL.
    get %r{^/([0-9A-Z]{10})\.jpg$} do |asin|
      product = find_or_create_product asin
      halt 404 if product.medium_image.nil?
      redirect product.medium_image.to_s, 301
    end

  end
end
