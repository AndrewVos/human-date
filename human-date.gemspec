# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "human-date/version"

Gem::Specification.new do |s|
  s.name        = "human-date"
  s.version     = Human::Date::VERSION
  s.authors     = ["Andrew Vos"]
  s.email       = ["andrew.vos@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Human readable date differences}
  s.description = %q{Human readable date differences}

  s.rubyforge_project = "human-date"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency "minitest"
end
