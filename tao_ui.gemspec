$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tao_ui/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tao_ui"
  s.version     = TaoUi::VERSION
  s.authors     = ["farthinker"]
  s.email       = ["farthinker@gmail.com"]
  s.homepage    = "https://github.com/mycolorway/tao_ui"
  s.summary     = "Tao UI"
  s.description = "UI library based on tao"
  s.license     = "MIT"

  s.files = Dir["{lib,vendor}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"
  s.add_dependency "tao_on_rails", "~> 0.8.0"

  s.add_development_dependency "sqlite3"
end
