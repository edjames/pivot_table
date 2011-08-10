# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'base64'

Gem::Specification.new do |s|
  s.name        = "pivot"
  s.version     = Pivot::VERSION
  s.authors     = ["Ed James"]
  s.email       = Base64.decode64("ZWQuamFtZXMuZW1haWxAZ21haWwuY29t\n")
  s.homepage    = "https://github.com/edjames/pivot"
  s.summary     = %q{A handy tool for transforming an ActiveRecord-esque data set into a spreadsheet-esque pivot table}
  s.description = %q{A handy tool for transforming an ActiveRecord-esque data set into a spreadsheet-esque pivot table}

  s.rubyforge_project = "pivot"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
