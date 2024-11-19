module Fremont
  class ConsoleCommand < BaseCommand
    def execute
      puts self.class.name
    end
  end
end