# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloud_shaped/version'

Gem::Specification.new do |gem|

  gem.name          = "cloud_shaped"
  gem.version       = CloudShaped::VERSION

  gem.summary       = %q{TODO: Write a short summary. Required.}
  gem.description   = %q{TODO: Write a longer description. Optional.}

  gem.authors       = ["Mike Williams"]
  gem.email         = ["mdub@dogbiscuit.org"]

  gem.homepage      = "http://github.com/mdub/cloud_shaped"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.6"
  gem.add_development_dependency "rake"

end
