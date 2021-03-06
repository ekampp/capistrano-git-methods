# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "capistrano-git-methods/version"

Gem::Specification.new do |s|
  s.name        = "capistrano-git-methods"
  s.version     = Capistrano::Git::Methods::VERSION
  s.authors     = ["Emil Kampp"]
  s.email       = ["emiltk@benjamin.dk"]
  s.homepage    = "http://emil.kampp.me"
  s.summary     = %q{Capistrano git methods}
  s.description = %q{Contains a git namespace with methods for deploying to a single folder using git as the versioning tool instead of the buildin capistrano versioning}

  s.rubyforge_project = "capistrano-git-methods"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "git"
  s.add_development_dependency "rake"
  s.add_development_dependency "yard"
  s.add_runtime_dependency "git"
  s.add_runtime_dependency "shell-spinner"
end
