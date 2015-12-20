# class TwilioController < ApplicationController
#   include Webhookable

#   after_filter :set_header

#   skip_before_action :verify_authenticity_token

#   def voice
#     response = Twilio::TwiML::Response.new do |r|
#       r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
#         r.Play 'http://linode.rabasa.com/cantina.mp3'
#     end

#     render_twiml response
#   end

#   def send_text_message
#     twilio_client.messages.create(
#       to: '8604628785',
#       from: ENV['TWILIO_PHONE_NUMBER'],
#       body: "Test message sent via Twilio"
#     )
#   end

# #=================================================
#   private
# #=================================================
#     def twilio_client
#       sid =   ENV['TWILIO_ACCOUNT_SID']
#       token = ENV['TWILIO_AUTH_TOKEN']
#       Twilio::REST::Client.new(sid, token)
#     end

# end