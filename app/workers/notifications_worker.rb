class NotificationsWorker
  include Sidekiq::Worker

  def perform(amount, terms)
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