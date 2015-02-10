# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','lfd_version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'lfd'
  s.description = <<-EOF
    LFD,  which stands for "Linux Flash Develop", will help you develop Flash and Flex applications on Linux.
  EOF
  s.version = Lfd::VERSION
  s.author = 'qhwa'
  s.email = 'qhwa@163.com'
  s.homepage = 'https://github.com/qhwa/LFD'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Flash develop tool on Linux'
# Add your other files here if you make them
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','lfd.rdoc']
  s.rdoc_options << '--title' << 'lfd' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'lfd'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')

  s.add_runtime_dependency('gli' )
  s.add_runtime_dependency('test-unit' )
  s.add_runtime_dependency('colored', '~> 1.2')
  s.add_runtime_dependency('activesupport', '~> 4.0')
end
