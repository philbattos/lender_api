module Api
  class TransactionsController < ApplicationController
    before_action :find_user, only: :create
    before_action :find_peer, only: :create
    respond_to :json

    def index
      @transactions = Transaction.all
    end

    def create
      trans = @user.transactions.new(transaction_params) {|t| t.peer_id = @peer.id }
      if trans.save
        # TO DO: ensure that client form contains validations for phone number and/or email address of peer
        NotificationsWorker.perform_async(trans.amount, trans.terms)
        render json: trans
      else
        render json: 422
      end
    end

    # def default_serializer_options
    #   { root: false }
    # end

  #=================================================
    private
  #=================================================
    def transaction_params
      params.require(:transaction).permit(:user_id, :peer_id, :amount, :terms)
    end

    def find_user
      @user ||= User.find_by(email: 'philbattos@gmail.com')
    end

    def find_peer
      @peer = User.find_or_create_by(email: params[:email])
    end

  end
end
