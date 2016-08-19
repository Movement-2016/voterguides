class ApplicationController < ActionController::Base
  force_ssl if: :ssl_configured?

  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

  class SuspendedUser < StandardError
    def message
      "User has been suspended"
    end
  end

  rescue_from SuspendedUser do |exception|
    redirect_to root_path, alert: exception.message
  end

  protected

  def current_user
    return unless session[:current_user_id]
    @current_user ||= ::User.find_by_secure_id session[:current_user_id]
  end
  helper_method :current_user

  def require_login
    return if current_user
    session[:redirect_to] = request.path
    redirect_to new_session_path
  end

  def require_admin_user!
    raise CanCan::AccessDenied unless current_user && current_user.admin?
  end

  def ssl_configured?
    Rails.env.production?
  end
end
