module Api
  class UsersController < ApplicationController
    # before_action :format_phone_number
    respond_to :json

    def index
      render json: User.all.order(:created_at)
    end

    def create
      # TO DO: ensure there is a validation on client form to accept phone numbers with correct formatting
      # once client-side validation is in place, consider removing :format_phone_number
      user = User.new(user_params)
      if user.save
        render json: user
      else
        render json: { errors: user.errors.full_messages }, status: 422
      end
    end

  #=================================================
    private
  #=================================================
    def user_params
      params.require(:user).permit(:name, :email, :phone)
    end

    # def format_phone_number
    #   raw_phone = params[:phone]
    #   if raw_phone.length == 10
    #     params[:phone] = raw_phone.gsub(/\D/, '').insert(0, '+1')
    #   end
    # end

  end
end
