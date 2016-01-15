class NotificationsWorker
  include Sidekiq::Worker

  def perform(transaction_id)
    # client will ensure that peer-user has a valid phone or email
    trans = Transaction.find(transaction_id)
    trans.peer.phone ? send_sms(trans) : send_email(trans)
  end

#=================================================
  private
#=================================================
  def send_sms(trans)
    if trans.peer.has_open_request?
      message = notice(trans)
    else
      trans.send_request! # change state of transaction to :requested_confirmation
      message = request(trans)
    end

    send_via_twilio(trans, message)
  end

  def send_email(trans)
    # TO DO: dispatch email
  end

  def send_via_twilio(trans, message)
    twilio_client.messages.create(
      to:   trans.peer.phone,
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: message
    )
  end

  def twilio_client
    sid   = ENV['TWILIO_ACCOUNT_SID']
    token = ENV['TWILIO_AUTH_TOKEN']
    Twilio::REST::Client.new(sid, token)
  end

  def request(trans)
    # TO DO: find a way
    "#{trans.user.full_name} would like to lend you $#{helper.number_to_currency(trans.amount)} to be paid back with #{trans.terms}% interest. If you accept this loan, reply YES."
  end

  def notice(trans)
    orig_request    = trans.peer.open_request
    orig_requester  = orig_request.user
    "#{trans.user.full_name} would like to lend you money but you currently have another pending request from #{orig_requester.full_name}. Please respond to #{orig_requester.firstname.possessive} request so that we can send you future loan requests."
  end

end