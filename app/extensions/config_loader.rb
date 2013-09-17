module Ahshok
  module Extensions
    module ConfigLoader

      # Load a YAML configuration file, read the pairs corresponding to the
      # current environment (development, staging, production, etc.), and turn
      # them into environment variables.
      def load_config(file)
        yaml  = YAML.load_file(file)
        pairs = yaml[environment.to_s]
        pairs.each_pair do |key, value|
          ENV[key.upcase] = value.to_s
        end unless pairs.nil?
      end

    end
  end
end
