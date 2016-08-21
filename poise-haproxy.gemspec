lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'poise_haproxy/version'

Gem::Specification.new do |spec|
  spec.name = 'poise-haproxy'
  spec.version = PoiseHaproxy::VERSION
  spec.authors = ['John Bellone']
  spec.email = %w{jbellone@bloomberg.net}
  spec.description = 'A Chef cookbook to manage Haproxy.'
  spec.summary = spec.description
  spec.homepage = 'https://github.com/johnbellone/poise-haproxy'
  spec.license = 'Apache 2.0'

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w{lib}

  spec.add_dependency 'chef', '~> 12.1'
  spec.add_dependency 'halite', '~> 1.1'
  spec.add_dependency 'poise', '~> 2.6'
  spec.add_dependency 'poise-languages', '~> 1.4'
  spec.add_dependency 'poise-service', '~> 1.1'

  spec.add_development_dependency 'berkshelf', '~> 4.0'
  spec.add_development_dependency 'poise-boiler', '~> 1.6'

  spec.metadata['halite_dependencies'] = 'yum-epel'
end
