# -*- coding: utf-8 -*-

require 'rdoc'
require 'rake'
require 'rdoc/task'
require 'rubygems/package_task'

begin
  require 'rspec/core/rake_task'
rescue LoadError
  puts 'no rspec'
else
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.ruby_opts = '-w'
    t.rcov = false
  end

  task default: :spec
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
def gemspec
  @gemspec ||= begin
    file = File.expand_path(File.join('..', 'run_checker.gemspec'), __FILE__)
    eval(File.read(file), binding, file)
  end
end

Gem::PackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end
task gem: :gemspec
