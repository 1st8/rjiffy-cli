# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rjiffy/cli/version'

Gem::Specification.new do |spec|
  spec.name          = "rjiffy-cli"
  spec.version       = Rjiffy::CLI::VERSION
  spec.authors       = ["Christoph"]
  spec.email         = ["christoph@mixxt.net"]
  spec.description   = %q{expose jiffybox API to cli}
  spec.summary       = %q{uses rjiffy as api client}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rjiffy'
  spec.add_dependency 'thor'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
