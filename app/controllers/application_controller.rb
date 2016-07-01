class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def current_user
    return unless session[:current_user_id]
    @current_user ||= User.find session[:current_user_id]
  end
  helper_method :current_user

  def require_login
    return if current_user
    session[:redirect_to] = request.path
    redirect_to new_session_path
  end
end
