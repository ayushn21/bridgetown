module Fremont
  class InstallCommand < BaseCommand
    def execute
      puts self.class.name
    end
  end
end