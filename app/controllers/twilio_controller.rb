module Twilio
  class SmsController < ApplicationController

    def create
      @sms = SMS.new(formatted_params)
      if @sms.save
        @transaction = find_transaction
        if @transaction
          if accepted_response.include? @sms.body.upcase
            @transaction.confirm!   # change state of transaction to 'active'
            render 'twilio/sms/confirmation.xml.erb', content_type: 'text/xml'
          else                      # unrecognized response; assume peer intends to decline loan offer
            @transaction.decline!   # change state of transaction to 'rejected'
            render 'twilio/sms/declined.xml.erb', content_type: 'text/xml'
          end
        else                        # peer has no pending requests
          render 'twilio/sms/unrequested.xml.erb'
        end
      else
        # TO DO: send notification to admin
        render 'twilio/sms/error.xml.erb', content_type: 'text/xml'
      end
    end

  #=================================================
    private
  #=================================================
    def find_transaction
      sender = User.find_by(phone: @sms.from)
      sender && sender.open_request
      # TO DO: What if there are more than one users with the same phone number?
      #        Do we really want to select the first in that group?
    end

    def accepted_response
      %w[ YES YS YE YA YAH YEAH YEP YUP YYES YYE YYA OK OOK OKK SURE FINE ]
    end

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