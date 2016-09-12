class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :check_for_captcha, only: :create

  def create
    @current_user = User.find_or_create_from_auth_hash!(auth_hash)
    raise SuspendedUser if @current_user.suspended?
    session[:current_user_id] = @current_user.to_param
    redirect_to session.delete(:redirect_to) || root_path
  rescue ActiveRecord::RecordInvalid
    render text: "Unable to find or create user"
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to new_session_path
  end
  protected

  def check_for_captcha
    return unless auth_hash['provider'] == 'identity'
    verify_recaptcha || redirect_to(new_session_path, notice: "Please try again")
  end

  def auth_hash
    request.env["omniauth.auth"].reduce({}) do |memo, (k, v)|
      memo[k] = v
      memo[k] = v.to_h if v.respond_to?(:to_h)
      memo
    end
  end
end
