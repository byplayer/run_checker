# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'run_checker/version'

Gem::Specification.new do |s|
  s.name = %q{run_checker}
  s.version = RunChecker::VERSION::STRING
  s.authors = ["byplayer"]
  s.date = %q{2014-10-07}
  s.description = "The duplicated running checker"
  s.email = ["byplayer100@gmail.com"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = FileList[
    '[A-Z]*',
    'bin/**/*',
    'lib/**/*.rb',
    'test/**/*.rb',
    'doc/**/*',
    'spec/**/*.rb',
  ]
  s.homepage = "https://github.com/byplayer/run_checker"
  s.rdoc_options = ["--charset=UTF-8", "--line-numbers", "--inline-source",
                    "--main", "README.rdoc", "-c UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{run_checker}
  s.rubygems_version = %q{0.1.0}
  s.summary = %q{The duplicated running checker}
  s.test_files = Dir.glob("spec/**/*")

  s.add_dependency("log4r")
end

