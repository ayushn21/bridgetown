# frozen_string_literal: true

require "clamp"

module Fremont
  autoload :InitCommand, "fremont/cli/init"

  class MainCommand < Clamp::Command
    subcommand "init", "Create a new deploy.yml", InitCommand
  end
end
