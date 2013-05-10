# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iamwriter/version'

Gem::Specification.new do |spec|
  spec.name          = "iamwriter"
  spec.version       = Iamwriter::VERSION
  spec.authors       = ["rsmacapinlac"]
  spec.email         = ["rsmacapinlac@gmail.com"]
  spec.description   = %q{This is a minimalist writing tool.}
  spec.summary       = %q{This is a minimalist writing tool.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "gtk2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
