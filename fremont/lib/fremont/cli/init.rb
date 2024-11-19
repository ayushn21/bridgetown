module Fremont
  class InitCommand < Clamp::Command
    def execute
      puts self.class.name
    end
  end
end