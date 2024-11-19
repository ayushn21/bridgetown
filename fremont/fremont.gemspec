# frozen_string_literal: true

require_relative "../bridgetown-foundation/lib/bridgetown/version"

Gem::Specification.new do |spec|
  spec.name           = "fremont"
  spec.version        = Bridgetown::VERSION
  spec.author         = "Bridgetown Team"
  spec.email          = "maintainers@bridgetownrb.com"

  spec.summary = "A deployment tool for Bridgetown websites."
  spec.homepage = "https://github.com/bridgetownrb/bridgetown/tree/main/fremont"
  spec.required_ruby_version = ">= 3.0.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features)/!) }
  spec.executables   = ["fremont", "frmt"]
  spec.bindir         = "bin"
  spec.require_paths  = ["lib"]

  spec.add_dependency "clamp", "~> 1.3.2"
  spec.add_dependency "net-ssh"
  spec.add_dependency "ed25519"
  spec.add_dependency "bcrypt_pbkdf"
end
