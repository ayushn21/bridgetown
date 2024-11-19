module Fremont
  class SetupCommand < BaseCommand
    def execute
      puts self.class.name
    end
  end
end