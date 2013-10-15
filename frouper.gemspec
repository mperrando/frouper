# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'frouper/version'

Gem::Specification.new do |spec|
  spec.name          = "frouper"
  spec.version       = Frouper::VERSION
  spec.authors       = ["Marco Perrando", "Luca Berruti"]
  spec.email         = ["frouper@soluzioninrete.it"]
  spec.description   = %q{Groups and stats}
  spec.summary       = %q{Groups data sliced in time and gives statistics on them.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
