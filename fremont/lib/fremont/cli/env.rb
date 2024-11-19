module Fremont
  class EnvCommand < BaseCommand
    def execute
      puts self.class.name
    end
  end
end