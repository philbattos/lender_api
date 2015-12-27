module Twilio
  class SmsController < ApplicationController

    def create
      puts params
      puts session.inspect
      sms_state = session[:sms_state]
      puts sms_state
      puts session.inspect
      @sms = SMS.new(formatted_params)
      @sms.save

      render xml: "<Response><Message>Test response from Twilio#create.</Message></Response>"
    end

  #=================================================
    private
  #=================================================
    def sms_parameters
      params.permit(:Body,
                    :To,
                    :From,
                    :ToCity,
                    :ToState,
                    :ToCountry,
                    :ToZip,
                    :SmsMessageSid,
                    :FromCity,
                    :FromState,
                    :FromCountry,
                    :FromZip,
                    :SmsSid,
                    :SmsStatus,
                    :NumMedia,
                    :NumSegments,
                    :MessageSid,
                    :AccountSid,
                    :ApiVersion
                    )
    end

    def formatted_params
      {
        body:             sms_parameters[:Body],
        to:               sms_parameters[:To],
        from:             sms_parameters[:From],
        to_city:          sms_parameters[:ToCity],
        to_state:         sms_parameters[:ToState],
        to_country:       sms_parameters[:ToCountry],
        to_zip:           sms_parameters[:ToZip],
        sms_message_sid:  sms_parameters[:SmsMessageSid],
        from_city:        sms_parameters[:FromCity],
        from_state:       sms_parameters[:FromState],
        from_country:     sms_parameters[:FromCountry],
        from_zip:         sms_parameters[:FromZip],
        sms_sid:          sms_parameters[:SmsSid],
        sms_status:       sms_parameters[:SmsStatus],
        num_media:        sms_parameters[:NumMedia],
        num_segments:     sms_parameters[:NumSegments],
        message_sid:      sms_parameters[:MessageSid],
        account_sid:      sms_parameters[:AccountSid],
        api_version:      sms_parameters[:ApiVersion]
      }
    end

  end
end