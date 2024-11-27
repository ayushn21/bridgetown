module Fremont
  class InitCommand < BaseCommand
    def execute
      super

      config_file_path = File.expand_path("../config/deploy.yml.erb", __dir__)
      config_file_template = File.read(config_file_path)

      config = ERB.new(config_file_template).result_with_hash(site_name: @site_name)

      File.write(File.join(Dir.pwd, "config", "deploy.yml"), config)
    end
  end
end