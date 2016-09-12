class PasswordResetsController < ApplicationController
  before_filter :locate_password_reset, only: [:show, :update]
  def new
    @password_reset = PasswordReset.new
  end

  def create
    @password_reset = PasswordReset.create(email: params[:password_reset][:email])
    if @password_reset.id
      PasswordResetMailer.reset_password(@password_reset.id).deliver_now
    end
    redirect_to root_path, notice: "If you have an account with us, you'll receive a password reset link in your email"
  end
  
  def show
  end

  def update
    if params[:identity][:password].present? && @password_reset.user.identity.update(pw_reset_params)
      @password_reset.touch :reset_at
      redirect_to new_session_path, notice: "Password updated, please log in"
    else
      flash.now[:notice] = "Try again"
      render :show
    end
  end

  protected

  def locate_password_reset
    @password_reset = PasswordReset.valid.where(reset_code: params[:id]).first!
  end

  def pw_request_params
    params.require(:password_reset).permit(:email)
  end

  def pw_reset_params
    params.require(:identity).permit(:password, :password_confirmation)
  end
end
