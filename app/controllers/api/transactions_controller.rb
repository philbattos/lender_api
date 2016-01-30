module Api
  class TransactionsController < ApplicationController
    before_action :find_peer, only: :create
    respond_to :json

    def index
      @open_transactions = current_user.transactions.open.order(:created_at)
    end

    def show
      @transaction = current_user.transactions.find(params[:id])
      # render json: @transaction # create jbuilder template?
    end

    def create
      trans = current_user.transactions.new(transaction_params) {|t| t.peer_id = @peer.id }
      puts "trans: #{trans.inspect}"
      puts "trans.errors: #{trans.errors}"
      puts "trans.valid?: #{trans.valid?}"
      if trans.save
        # TO DO: ensure that client form contains validations for phone number and/or email address of peer
        NotificationsWorker.perform_async(trans.id)
        render json: trans # create jbuilder template?
      else
        render json: 422
      end
    end

  #=================================================
    private
  #=================================================
    def transaction_params
      params.require(:transaction).permit(:id, :user_id, :peer_id, :amount, :terms)
    end

    def find_peer
      format_phone
      puts "format_phone: #{format_phone}"
      puts "params[:phone]: #{params[:phone]}"
      @peer = User.find_or_create_by(phone: params[:phone]) do |peer|
        peer.firstname  = params[:firstname]
        peer.lastname   = params[:lastname]
        peer.email      = params[:email]
      end
      puts "peer.errors: #{@peer.errors}"
      puts "peer.inspect: #{@peer.inspect}"
    end

    def format_phone
      # client should ensure that all phone numbers are 10-digits long
      params[:phone].prepend('+1') # prefix numbers with +1 to match Twilio formatting
    end

  end
end
