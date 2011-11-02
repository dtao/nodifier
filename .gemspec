require 'rake'

Gem::Specification.new do |s|
  s.name        = 'nodifier'
  s.version     = '0.1.0'
  s.summary     = 'A simple Ruby library for parsing plain text into a node-based structure'
  s.author     = 'Daniel Tao'
  s.email       = 'daniel.tao@gmail.com'
  s.files       = FileList['src/**/*'].to_a
  s.homepage    = 'http://github.com/dtao/nodifier'
end