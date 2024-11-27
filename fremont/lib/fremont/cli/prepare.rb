module Fremont
  class PrepareCommand < BaseCommand
    def execute
      super

      prepare_sh = File.read(File.expand_path("../scripts/prepare.sh", __dir__))
      execute_on_server(prepare_sh, user: "root")
    end
  end
end