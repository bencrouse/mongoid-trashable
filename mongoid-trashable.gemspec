# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/trashable/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid-trashable"
  spec.version       = Mongoid::Trashable::VERSION
  spec.authors       = ["Ben Crouse"]
  spec.email         = ["bencrouse@gmail.com"]

  spec.summary       = %q{Allows Mongoid::Documents to be moved to a trash collection.}
  spec.description   = %q{As a more cleaner alternative to Mongoid::Paranoia, allows Mongoid::Documents to be moved to a trash collection.}
  spec.homepage      = "https://github.com/bencrouse/mongoid-trashable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'mongoid', '>= 4.0'

  spec.add_development_dependency "bundler", ">= 2.1.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
end
