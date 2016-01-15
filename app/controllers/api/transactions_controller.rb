module Api
  class TransactionsController < ApplicationController
    before_action :find_user, only: :create
    before_action :find_peer, only: :create
    respond_to :json

    def index
      @open_transactions = Transaction.open.order(:created_at)
    end

    def show
      @transaction = Transaction.find(params[:id])
      render json: @transaction # create jbuilder template?
    end

    def create
      trans = @user.transactions.new(transaction_params) {|t| t.peer_id = @peer.id }
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

    def find_user
      @user ||= User.find_by(email: 'philbattos@gmail.com')
    end

    def find_peer
      # @peer = User.find_or_create_by(email: params[:email])
      @peer = User.find_or_create_by(email: 'philbattos@gmail.com')
    end

  end
end
