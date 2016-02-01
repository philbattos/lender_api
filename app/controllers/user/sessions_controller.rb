class User::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    puts "SESSION-1 current_user: #{current_user.id}"
    sign_out(:user) if current_user
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    puts "SESSION-2 current_user: #{current_user.id}"
    yield resource if block_given?
    # respond_with resource
    render json: resource
    # after_sign_in_path_for(resource)
  end
end