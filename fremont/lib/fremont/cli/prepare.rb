module Fremont
  class PrepareCommand < BaseCommand
    def execute
      puts self.class.name
    end
  end
end