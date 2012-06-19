# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mass-rename/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kolja Kube"]
  gem.email         = ["kolja.kube@gmail.com"]
  gem.description   = File.read('README.md')
  gem.summary       = %q{A small utility to quickly rename files with numbering}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mass-rename"
  gem.require_paths = ["lib"]
  gem.version       = MassRename::VERSION
  
  gem.add_development_dependency 'minitest',        '>= 3.0.0'
  gem.add_development_dependency 'guard',           '>= 1.0.0'
  gem.add_development_dependency 'guard-minitest',  '>= 0.5.0'
  # The following two are OSX-specific:
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'growl'
end
