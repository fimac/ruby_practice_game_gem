Gem::Specification.new do |s|
  s.name         = "player_game_ruby_practice"
  s.version      = "1"
  s.author       = "Fi"
  s.email        = ""
  s.homepage     = ""
  s.summary      = "Ruby Practice"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'studio_game' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec', '~> 2.8', '>= 2.8.0'
end