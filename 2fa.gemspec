require_relative 'lib/2fa.rb'

Gem::Specification.new do |s|
  s.name        = '2fa'
  s.version     = TFA.version
  s.summary     = 'A gem for two factor authentication in rails apps'
  s.description = s.summary
  s.authors     = ["Matthias Lee"]
  s.email       = 'matthias@matthiasclee.com'
  s.files       = [
    'lib/2fa.rb',
    'lib/2fa/twilio.rb',
    'app/views/2fa/_test.html.erb'
  ]
  s.add_runtime_dependency 'twilio-ruby', '>= 5.66.0'
  s.add_runtime_dependency 'rails'
  #s.require_paths = ["lib"]
  #s.homepage = 'https://github.com/Matthiasclee/RBText'
end
