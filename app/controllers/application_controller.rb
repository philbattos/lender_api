class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  after_filter :set_csrf_cookie_for_ng # http://solidfoundationwebdev.com/blog/posts/how-to-set-csrf-with-angularjs-and-rails

#=================================================
  protected
#=================================================
  # In Rails 4.2 and above
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

#=================================================
  private
#=================================================
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

end
