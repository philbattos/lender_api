module Api
  class TransactionsController < ApplicationController
    before_action :find_peer, only: :create
    respond_to :json

    def index
      render json: Transaction.all
    end

    def create
      trans = Transaction.create(transaction_params) {|t| t.peer_id = @peer.id }
      if trans
        NotificationsWorker.perform_async(trans.amount, trans.terms)
        render json: trans
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
      @peer = User.find_or_create_by(email: params[:email])
    end

  end
end
