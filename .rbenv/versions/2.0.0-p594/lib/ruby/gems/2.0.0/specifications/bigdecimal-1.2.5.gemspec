# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bigdecimal"
  s.version = "1.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kenta Murata", "Zachary Scott", "Shigeo Kobayashi"]
  s.date = "2014-01-15"
  s.description = "This library provides arbitrary-precision decimal floating-point number class."
  s.email = "mrkn@mrkn.jp"
  s.extensions = ["extconf.rb"]
  s.files = ["extconf.rb"]
  s.homepage = "http://www.ruby-lang.org"
  s.require_paths = ["."]
  s.rubygems_version = "2.0.3"
  s.summary = "Arbitrary-precision decimal floating-point number library."
end
