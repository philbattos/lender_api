module Api
  class TransactionsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_peer, only: :create
    respond_to :json

    def index
      @open_transactions = current_user.transactions.open.order(:created_at)
    end

    def old_transactions
      @old_transactions = current_user.transactions.closed.order(:created_at)
    end

    def show
      @transaction = current_user.transactions.find(params[:id])
      # render json: @transaction # create jbuilder template?
    end

    def create
      trans = current_user.transactions.new(transaction_params) {|t| t.peer_id = @peer.id }
      if trans.save!
        # TO DO: ensure that client form contains validations for phone number and/or email address of peer
        NotificationsWorker.perform_async(trans.id)
        render json: trans # create jbuilder template?
      else
        render json: { errors: trans.errors.full_messages }, status: 422
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
      @peer = User.find_or_create_by!(phone: params[:phone]) do |peer|
        peer.firstname  = params[:firstname]
        peer.lastname   = params[:lastname]
        peer.email      = params[:email]
      end
    end

    def format_phone
      # client should ensure that all phone numbers are 10-digits long
      params[:phone].prepend('+1') # prefix numbers with +1 to match Twilio formatting
    end

  end
end
