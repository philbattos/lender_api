class NotificationsWorker
  include Sidekiq::Worker

  def perform(amount, terms)
    # if phone
    #   send_sms
    # elsif email
    #   send_email
    # else
    #   send error to client
    # end

    # if user.has_open_request?
    #   send message to peer: "{{so-and-so}} would like to lend you money but you currently have a request from {{someone-else}}. Please respond to {{someone-else's}} request so that we can send you future loan requests."
    # else
    #   send_sms
    # end

    # change state of transaction to :requested_confirmation

    twilio_client.messages.create(
      to: '8604628785',
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: lending_message(amount, terms)
    )
  end

#=================================================
  private
#=================================================
  def twilio_client
    sid   = ENV['TWILIO_ACCOUNT_SID']
    token = ENV['TWILIO_AUTH_TOKEN']
    Twilio::REST::Client.new(sid, token)
  end

  def lending_message(amount, terms)
    "***TEST*** Someone would like to lend you $#{amount} to be paid back with #{terms}. Do you accept the loan with these terms?"
  end

end