module Fremont
  class InitCommand < BaseCommand
    def execute
      puts self.class.name
    end
  end
end