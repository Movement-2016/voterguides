class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

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
