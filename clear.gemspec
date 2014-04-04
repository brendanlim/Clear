require File.join([File.dirname(__FILE__),'lib','clear','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'clear'
  s.version = ClearMod::VERSION
  s.author = 'Brendan G. Lim'
  s.email = 'brendangl@gmail.com'
  s.homepage = 'http://brendanlim.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Command line interface for the Clear to do list Mac application.'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = false
  s.bindir = 'bin'
  s.executables << 'clr'
  s.license = 'MIT'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.9.0')

  s.post_install_message = "Type 'clr help' for usage information"
end
