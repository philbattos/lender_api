module Twilio
  class SmsController < ApplicationController

    def create
      puts params
      params.to_a.map {|x| params[x[0].to_s.underscore.to_sym] = params.delete(x[0])}
      @sms = SMS.new(params)
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

  end
end