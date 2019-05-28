# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sommelier/version'

Gem::Specification.new do |spec|
  spec.name          = 'tcollier-sommelier'
  spec.version       = Sommelier::VERSION
  spec.authors       = ['Tom Collier']
  spec.email         = ['tcollier@gmail.com']

  spec.summary       = 'Ruby implementation of a Stable Marriage solver'
  spec.homepage      = 'https://github.com/tcollier/sommelier'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'simplecov', '~> 0.16'
end
