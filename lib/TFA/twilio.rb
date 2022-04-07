module TFA
  module Twilio
    @@acc_sid = ENV["TWILIO_ACCOUNT_SID"]
    @@auth_token = ENV["TWILIO_AUTH_TOKEN"]
    @@sending_phone = ENV["TWILIO_SENDING_PHONE"]
    @@client = ::Twilio::REST::Client.new(@@acc_sid, @@auth_token)
    
    mattr_reader :acc_sid
    mattr_reader :auth_token
    mattr_accessor :sending_phone

    def self.send_msg(message, to:)
      @@client.messages.create(
        body: message,
        from: @@sending_phone,
        to: to
      ).sid
    end
  end
end
