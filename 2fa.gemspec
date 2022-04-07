require_relative 'lib/TFA/version.rb'

Gem::Specification.new do |s|
  s.name        = '2fa'
  s.version     = TFA.version
  s.summary     = 'Two factor authentication in rails apps made easy'
  s.description = 'An easy way to add sms-based two factor authentication to rails apps with Twilio'
  s.authors     = ["Matthias Lee"]
  s.email       = 'matthias@matthiasclee.com'
  s.files       = Dir.glob("**/*")
  s.files.delete("2fa-#{TFA.version}.gem")
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'twilio-ruby', '>= 5.66.0'
  s.add_runtime_dependency 'rails', '>= 6.1.0'
  s.homepage = 'https://github.com/Matthiasclee/2fa'
end
