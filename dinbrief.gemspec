# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dinbrief/version"

Gem::Specification.new do |s|
  s.name        = "dinbrief"
  s.version     = Dinbrief::VERSION
  s.authors     = ["Peter Horn"]
  s.email       = ["peter.horn@provideal.net"]
  s.homepage    = "http://github.com/provideal/dinbrief"
  s.summary     = %q{DIN Letter gem for Prawn}
  s.description = %q{DIN Brief gem for Prawn. Creating letters that confirm to the DIN 5008 specifications.}

  s.rubyforge_project = "dinbrief"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "prawn", "1.0.0.rc1"
  # s.add_runtime_dependency "rest-client"
end
