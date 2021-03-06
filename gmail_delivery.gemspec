$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gmail_delivery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gmail_delivery"
  s.version     = GmailDelivery::VERSION
  s.authors     = ["aspick"]
  s.email       = ["info@aspick.net"]
  s.homepage    = "https://github.com/aspick/gmail_delivery"
  s.summary     = "Use Gmail API for ActoinMailer deliver! method"
  s.description = "Use Gmail API for ActoinMailer deliver! method"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.1"
  s.add_dependency "google-api-client", '~> 0.11'
  s.add_dependency "signet"
  s.add_dependency "googleauth"
  s.add_dependency "launchy"

  s.add_development_dependency "sqlite3"
end
