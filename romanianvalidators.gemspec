# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'romanianvalidators'
  s.version     = '0.1.3'
  s.authors     = ['Mihai Târnovan']
  s.email       = ['mihai.tarnovan@cubus.ro']
  s.homepage    = 'http://github.com/mtarnovan/romanianvalidators'
  s.license     = 'MIT'
  s.summary     = %q{Collection of validations for Cod Numeric Personal (CNP), Cod de identificare fiscală (CIF) and IBAN (only Romanian format, as published by Romanian National Bank)}
  s.description = %q{Collection of validations for Cod Numeric Personal (CNP), Cod de identificare fiscală (CIF) and IBAN (only Romanian format, as published by Romanian National Bank).}

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'
  s.add_dependency 'rake'          , '>= 0.8.7'
  s.add_dependency 'activemodel'   , '>= 3.0.0'

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.rubyforge_project = "romanianvalidators"
end