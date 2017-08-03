# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-view_data-pg'
  s.version = '0.1.0.0'
  s.summary = 'Create and populate PostgreSQL view databases from event streams'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-contrib/view-data-pg'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4.0'

  s.add_runtime_dependency 'evt-consumer-postgres'
  s.add_runtime_dependency 'evt-view_data-commands'

  s.add_development_dependency 'test_bench'
end
