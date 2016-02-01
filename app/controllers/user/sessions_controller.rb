class User::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    puts "SESSION-1 current_user: #{current_user.id}"
    puts "SESSION-1 user: #{:user}"
    sign_out(current_user) if current_user
    puts "SESSION-2 current_user: #{current_user.id}"
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    puts "SESSION-3 current_user: #{current_user.id}"
    puts "resource: #{resource.inspect}"
    puts "session: #{session.inspect}"
    # respond_with resource
    render json: resource
    # after_sign_in_path_for(resource)
  end
end