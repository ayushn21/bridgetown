module Fremont
  class PushCommand < BaseCommand
    def execute
      puts self.class.name
    end
  end
end