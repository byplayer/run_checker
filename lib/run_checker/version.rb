# -*- coding: utf-8 -*-

module RunChecker
  # version information module
  module VERSION
    STRING =
      File.open(
        File.join(
                  File.dirname(__FILE__), '..', '..', 'VERSION'), 'r') do |f|
        f.gets.chomp
      end

    if STRING =~ /^([0-9]+)\.([0-9]+)\.([0-9]+)/
      MAJOR = Regexp.last_match(1).to_i
      MINOR = Regexp.last_match(2).to_i
      TINY  = Regexp.last_match(3).to_i
    end
  end
end
