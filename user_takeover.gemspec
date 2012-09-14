$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "user_takeover/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "user_takeover"
  s.version     = UserTakeover::VERSION
  s.authors     = ["Dr Nic Williams", "Many people at Engine Yard"]
  s.email       = ["drnicwilliams@gmail.com"]
  s.homepage    = "https://drnic.github.com/user-takeover"
  s.summary     = "Allow staff users to pretend to be your customers"
  s.description = "Allow staff users to pretend to be your customers; to takeover their account."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "cucumber-rails"
  s.add_development_dependency "database_cleaner"
end
