module Twilio
  class SmsController < ApplicationController

    def create
      @sms = SMS.new(formatted_params)
      if @sms.save
        # transaction = find_transaction
        if accepted_response.include? @sms.body.upcase
          # transaction.mark_as_accepted_by_peer
          render xml: '<Response><Message>Congratulations, {{so-and-so}} has lent you {{amount}} for {{terms}}. You can view this on friend-lender-app.</Message></Response>'
        else
          render xml: '<Response><Message>Ok, we will inform {{so-and-so}} that you have declined their offer.</Message></Response>'
        end
        # render xml: "<Response><Message>Test response from Twilio#create.</Message></Response>"
      else
        render xml: "<Response><Message>There was an error. Please try again.</Message></Response>"
        # send notification to admin
      end
    end

  #=================================================
    private
  #=================================================
    def find_transaction
      # transaction = User.find_by(phone: @sms.from).open_request
      # Transaction.find_by(user_id: params[], peer_id: @sms.from)
    end

    def accepted_response
      %w[ YES YE YA YEAH YEP YUP OK SURE FINE ]
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