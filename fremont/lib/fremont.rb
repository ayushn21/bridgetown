# frozen_string_literal: true

require "clamp"

module Fremont
  autoload :Config,             "fremont/config"
  autoload :SSH,                "fremont/ssh"

  autoload :InitCommand,        "fremont/cli/init"
  autoload :PrepareCommand,     "fremont/cli/prepare"
  autoload :SetupCommand,       "fremont/cli/setup"
  autoload :InstallCommand,     "fremont/cli/install"
  autoload :EnvCommand,         "fremont/cli/env"
  autoload :PushCommand,        "fremont/cli/push"
  autoload :ConsoleCommand,     "fremont/cli/console"

  class BaseCommand < Clamp::Command
    include Fremont::SSH
  end

  class MainCommand < Clamp::Command
    subcommand "init",          "Create a new deploy.yml",                              InitCommand
    subcommand "prepare",       "Prepare your server for web hosting",                  PrepareCommand
    subcommand "install",       "Install Caddy, Ruby and Node.JS on your server",       InstallCommand
    subcommand "setup",         "Prepare your server and install required software",    SetupCommand
    subcommand "env",           "Edit your production environment variables",           EnvCommand
    subcommand "push",          "Push and deploy your code",                            PushCommand
    subcommand "console",       "Access your production console",                       ConsoleCommand
  end
end
