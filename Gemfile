source 'https://rubygems.org/'

gemspec path: File.expand_path('..', __FILE__)

def dev_gem(name, path: File.join('..', name), github: nil)
  path = File.expand_path(File.join('..', path), __FILE__)
  if File.exist?(path)
    gem name, path: path
  elsif github
    gem name, github: github
  end
end

dev_gem 'halite'
dev_gem 'poise'
dev_gem 'poise-boiler'
dev_gem 'poise-languages', github: 'poise/poise-languages'
dev_gem 'poise-profiler'
dev_gem 'poise-service'
