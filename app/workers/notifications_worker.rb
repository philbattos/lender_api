class NotificationsWorker
  include Sidekiq::Worker

  def perform(transaction_id)
    trans = Transaction.find(transaction_id)
    trans.peer.phone ? send_sms(trans) : send_email(trans)
  end

#=================================================
  private
#=================================================
  def send_sms(trans)
    message = trans.peer.has_open_request? ? notice(trans) : request(trans)
    send_via_twilio(trans, message)
  end

  def send_email(trans)
    # TO DO: dispatch email
  end

  def send_via_twilio(trans, message)
    begin
      twilio_client.messages.create(
        to:   trans.peer.phone,
        from: ENV['TWILIO_PHONE_NUMBER'],
        body: message
      )
      trans.send_request! # change state of transaction to :requested_confirmation
                          # if text is successfully sent to peer
    rescue Twilio::REST::RequestError => e
      puts e.message
      puts "TWILIO CODE: #{e.code}"
      puts "TWILIO EXCEPTION: #{e.exception}"
      puts "TWILIO OPTIONS: #{e.methods}"
      # notify admin or user that notification could not be sent to peer
      # ...or try to re-send text later
    end
  end

  def twilio_client
    sid   = ENV['TWILIO_ACCOUNT_SID']
    token = ENV['TWILIO_AUTH_TOKEN']
    Twilio::REST::Client.new(sid, token)
  end

  def request(trans)
    "#{trans.user.full_name} would like to lend you #{ActionController::Base.helpers.number_to_currency(trans.amount)} to be paid back with #{trans.terms}% interest. If you accept this loan, reply YES."
  end

  def notice(trans)
    orig_request    = trans.peer.open_request
    orig_requester  = orig_request.user
    "#{trans.user.full_name} would like to lend you money but you currently have another pending request from #{orig_requester.full_name}. Please respond to #{orig_requester.firstname.possessive} request so that we can send you future loan requests."
  end

end