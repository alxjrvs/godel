# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'godel/version'

Gem::Specification.new do |spec|
  spec.name          = "godel"
  spec.version       = Godel::VERSION
  spec.authors       = ["Alex Jarvis"]
  spec.email         = ["alxjrvs@gmail.com"]
  spec.description   = %q{Validations, except they don't do anything.}
  spec.summary       = %q{In Rails apps, it is possible that a model might want another state above 'valid' or 'invalid'. Unreliable inputs may put you in a situation where you can not guarantee the  integrity of every entry in your database, but strict validations might cause you to lose fuzzy data. This gem gives another 'state' about validity, "completeness". A model can require certain attributes or methods to be present in order to be 'complete', giving you another powerful tool when solidfying the integrity of your data. }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "byebug"
end
