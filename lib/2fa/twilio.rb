module TFA
  module Twilio
    @@account_sid = ENV['TWILIO_ACCOUNT_SID']
    @@auth_token = ENV['TWILIO_AUTH_TOKEN']
    @@sending_phone_number = ENV['TWILIO_SENDING_PHONE_NUMBER']

    def self.account_sid
      @@account_sid
    end

    def self.auth_token
      @@auth_token
    end

    def self.sending_phone_number
      @@sending_phone_number
    end

    def self.account_sid=(a)
      @@account_sid = a
    end

    def self.auth_token=(a)
      @@auth_token = a
    end

    def self.sending_phone_number=(a)
      @@sending_phone_number = a
    end
  end
end
