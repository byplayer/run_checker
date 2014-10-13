# -*- coding: utf-8 -*-
require 'rdoc'
require 'rake'
require 'rdoc/task'
require 'rubygems/package_task'
require 'bundler/setup'

lib = File.expand_path(File.join('..', 'lib/'), __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require 'run_checker/version'

begin
  require 'rspec/core/rake_task'
rescue LoadError
  puts 'no rspec'
else
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.ruby_opts = '-w'
  end

  task default: :spec
end

begin
  require 'rubocop/rake_task'
rescue LoadError
  puts 'no rubocop'
else
  RuboCop::RakeTask.new
end

Rake::RDocTask.new do |rdoc|
  begin
    version = File.read('VERSION').chomp
  rescue
    version = '0.0.0'
    puts "No version is set in file VERSION.  Set by default to #{version}"
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "run_checker #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')

  rdoc.options += [
    '-H', '-a', '-t', '-d',
    '-f', 'darkfish',  # This is the important bit
  ]
end

# gem task
gemspec = Gem::Specification.new do |s|
  s.name = 'run_checker'
  s.version = RunChecker::VERSION::STRING
  s.authors = ['byplayer']
  s.date = '2014-10-07'
  s.description = 'The duplicated running checker'
  s.email = ['byplayer100@gmail.com']
  s.extra_rdoc_files = [
    'README.rdoc'
  ]
  s.files = FileList[
    '[A-Z]*',
    'bin/**/*',
    'lib/**/*.rb',
    'test/**/*.rb',
    'doc/**/*',
    'spec/**/*.rb',
  ]
  s.homepage = 'https://github.com/byplayer/run_checker'
  s.rdoc_options = ['--charset=UTF-8', '--line-numbers', '--inline-source',
                    '--main', 'README.rdoc', '-c UTF-8']
  s.require_paths = ['lib']
  s.rubyforge_project = 'run_checker'
  s.rubygems_version = '0.1.0'
  s.summary = 'The duplicated running checker'
  s.test_files = Dir.glob('spec/**/*')

  s.add_dependency('log4r')
end

Gem::PackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end
