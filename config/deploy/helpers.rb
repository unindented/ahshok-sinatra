module Ahshok
  class Deploy

    def self.with_configuration(&block)
      Capistrano::Configuration.instance(:must_exist).load(&block)
    end

    def self.ask(msg, default = nil)
      Capistrano::CLI.ui.ask(msg) { |q| q.default = default }
    end

    def self.psk(msg, echo = false)
      Capistrano::CLI.ui.ask(msg) { |q| q.echo = echo }
    end

  end
end

require File.expand_path('../helpers/passenger', __FILE__)
require File.expand_path('../helpers/config', __FILE__)
