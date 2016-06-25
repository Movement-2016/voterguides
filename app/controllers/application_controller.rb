class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    return unless session[:current_user_id]
    @current_user ||= User.find session[:current_user_id]
  end
  helper_method :current_user
end
