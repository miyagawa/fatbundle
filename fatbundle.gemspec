# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fatbundle/version'

Gem::Specification.new do |spec|
  spec.name          = "fatbundle"
  spec.version       = Fatbundle::VERSION
  spec.authors       = ["Tatsuhiko Miyagawa"]
  spec.email         = ["miyagawa@bulknews.net"]

  spec.summary       = %q{Create a single, fat bundle of your Ruby script using Bundler}
  spec.homepage      = "https://github.com/miyagawa/fatbundle"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
