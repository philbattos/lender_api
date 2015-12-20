module Api
  class TransactionsController < ApplicationController
    before_action :find_peer, only: :create
    respond_to :json

    def index
      render json: Transaction.all
    end

    def create
      puts params
      transaction = Transaction.create(transaction_params) {|t| t.peer_id = @peer.id }
      if transaction
        amount  = transaction.amount
        terms   = transaction.terms
        send_text_message(amount, terms)
        render json: transaction
      else
        render json: 422
      end
    end

    def default_serializer_options
      { root: false }
    end

  #=================================================
    private
  #=================================================
    def transaction_params
      params.require(:transaction).permit(:user_id, :peer_id, :amount, :terms)
    end

    def find_peer
      @peer = User.find_by(email: params[:email])
    end

    def send_text_message(amount, terms)
      twilio_client.messages.create(
        to: '8604628785',
        from: ENV['TWILIO_PHONE_NUMBER'],
        body: lending_message(amount, terms)
      )
    end

    def twilio_client
      sid   = ENV['TWILIO_ACCOUNT_SID']
      token = ENV['TWILIO_AUTH_TOKEN']
      Twilio::REST::Client.new(sid, token)
    end

    def lending_message(amount, terms)
      "***TEST*** Someone would like to lend you $#{amount} to be paid back with #{terms}. Do you accept the loan with these terms?"
    end

  end
end
