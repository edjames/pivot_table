# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pivot_table', __FILE__)
require 'base64'

Gem::Specification.new do |s|
  s.name        = "pivot_table"
  s.version     = PivotTable::VERSION
  s.authors     = ["Ed James"]
  s.email       = Base64.decode64("ZWQuamFtZXMuZW1haWxAZ21haWwuY29t\n")
  s.homepage    = "https://github.com/edjames/pivot_table"
  s.summary     = "pivot_table-#{s.version}"
  s.description = "Transform an ActiveRecord-ish data set into a pivot table of objects"

  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9'

  s.rubyforge_project = "pivot_table"
  s.rubygems_version  = "~> 2.2"
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_paths     = ["lib"]

  s.add_development_dependency "rspec", "~> 3.1"
  s.add_development_dependency "growl", "~> 1.0"
  s.add_development_dependency "guard-rspec", "~> 4.3"
end
