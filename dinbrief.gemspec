DINBRIEF_VERSION = "0.9.0"

Gem::Specification.new do |spec|
  spec.name          = "dinbrief"
  spec.version       = DINBRIEF_VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.summary       = "DIN Brief gem for Prawn"
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.rdoc_options  = ['--charset=UTF-8']
  spec.require_path  = "lib"
  spec.required_ruby_version = '>= 1.9.2'
  spec.required_rubygems_version = ">= 1.3.6"
  spec.authors       = ["Peter Horn"]
  spec.email         = ["ph@metaminded.com"]
  spec.rubyforge_project = "dinbrief"
  spec.add_dependency('prawn', '>=1.0.0.rc1')
  spec.homepage      = "https://github.com/provideal/dinbrief"
  spec.description   = <<-END_DESC
    DIN Brief gem for Prawn. Creating letters that confirm to the DIN specifications. For Ruby.
  END_DESC
end
