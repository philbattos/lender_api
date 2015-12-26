module Twilio
  class SmsController < ApplicationController

    def create
      puts params
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
        sms_message_sid:  sms_parameters[:SmsMessageSid],
        num_media:        sms_parameters[:NumMedia],
        to_city:          sms_parameters[:ToCity],
        from_zip:         sms_parameters[:FromZip],
        sms_sid:          sms_parameters[:SmsSid],
        from_state:       sms_parameters[:FromState],
        sms_status:       sms_parameters[:SmsStatus],
        from_city:        sms_parameters[:FromCity],
        body:             sms_parameters[:Body],
        from_country:     sms_parameters[:FromCountry],
        to:               sms_parameters[:To],
        to_zip:           sms_parameters[:ToZip],
        num_segments:     sms_parameters[:NumSegments],
        message_sid:      sms_parameters[:MessageSid],
        account_sid:      sms_parameters[:AccountSid],
        from:             sms_parameters[:From],
        api_version:      sms_parameters[:ApiVersion]
      }
    end

  end
end