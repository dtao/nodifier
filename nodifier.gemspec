require 'rake'

Gem::Specification.new do |s|
  s.name        = 'nodifier'
  s.version     = '0.1.6'
  s.summary     = 'Nodifier, for parsing text into nodes'
  s.description = 'A simple Ruby library for parsing plain text into a node-based structure'
  s.author      = 'Daniel Tao'
  s.email       = 'daniel.tao@gmail.com'
  s.files       = FileList['lib/**/*'].to_a
  s.homepage    = 'http://github.com/dtao/nodifier'
end