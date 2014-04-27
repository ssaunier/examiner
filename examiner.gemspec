# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'examiner/version'

Gem::Specification.new do |spec|
  spec.name          = "examiner"
  spec.version       = Examiner::VERSION
  spec.authors       = ["Sebastien Saunier"]
  spec.email         = ["seb@saunier.me"]
  spec.summary       = %q{Grade a student's exercise solution using rake and minitest}
  spec.description   = spec.summary
  spec.homepage      = "http://github.com/ssaunier/examiner"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
