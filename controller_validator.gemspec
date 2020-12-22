# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'controller_validator/version'

Gem::Specification.new do |spec|
  spec.name          = "controller_validator"
  spec.version       = ControllerValidator::VERSION
  spec.authors       = ["Peter Boling"]
  spec.email         = ["peter.boling@gmail.com"]
  spec.summary       = %q{Simple Validations in the Controller}
  spec.description   = %q{Use the familiar ActiveModel::Errors pattern for controller validations}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "reek"
  spec.add_development_dependency "roodi"

  spec.add_dependency "activemodel", ">= 3"
end
