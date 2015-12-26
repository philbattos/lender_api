module Twilio
  class SmsController < ApplicationController

    def create
      puts params
      # sms_parameters.to_a.map {|x| sms_parameters[x[0].to_s.underscore.to_sym] = sms_parameters.delete(x[0])}
      @sms = SMS.new(formatted_params)
      @sms.save

      render xml: "<Response><Message>Test response from Twilio#create.</Message></Response>"
    end

  #=================================================
    private
  #=================================================
    def sms_parameters
      params.permit(:ToCountry,
                    :ToState,
                    :SmsMessageSid,
                    :NumMedia,
                    :ToCity,
                    :FromZip,
                    :SmsSid,
                    :FromState,
                    :SmsStatus,
                    :FromCity,
                    :Body,
                    :FromCountry,
                    :To,
                    :ToZip,
                    :NumSegments,
                    :MessageSid,
                    :AccountSid,
                    :From,
                    :ApiVersion
                    )
    end

    def formatted_params
      {
        to_country:       sms_parameters[:ToCountry],
        to_state:         sms_parameters[:ToState],
        sms_message_sid:  sms_parameters[:SmsMessageSid]
      }
    end

  end
end