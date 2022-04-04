require 'twilio-ruby'
require_relative "2fa/twilio.rb"

module TFA
  @@version = {
    major: 0,
    minor: 0,
    patch: 1,
    extra: [
    ]
  }

  def self.version
    "#{@@version[:major]}.#{@@version[:minor]}.#{@@version[:patch]}#{"." if @@version[:extra].length > 0}#{@@version[:extra].join(".")}"
  end
end

class Engine < Rails::Engine
  config.autoload_paths << File.expand_path(__dir__)
end
