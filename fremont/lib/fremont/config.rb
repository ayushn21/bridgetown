module Fremont
  class Config
    def self.current
      config = YAML.load_file(File.join(Dir.pwd, "config", "deploy.yml"))
      new(config)
    end

    def initialize(config)
      @config = config
    end

    def validate
    end

    def [](key)
      @config[key]
    end
  end
end