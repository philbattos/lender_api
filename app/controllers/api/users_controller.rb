module Api
  class UsersController < ApplicationController
    respond_to :json

    def index
      render json: User.all
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user
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
    def user_params
      params.require(:user).permit(:name, :email, :phone)
    end

  end
end
