class EmailConfirmationsController < ApplicationController
  before_action :require_login

  def new
    @email_confirmation = EmailConfirmation.new(user: current_user, email: params[:email] || current_user.email)
  end

  def create
    @email_confirmation = current_user.email_confirmations.build email_confirmation_params
    if @email_confirmation.save
      EmailConfirmationMailer.confirmation_code(@email_confirmation.id).deliver_now
      flash[:notice] = "Email sent to #{@email_confirmation.email}"
      redirect_to new_email_confirmation_path(email: @email_confirmation.email)
    else
      render :new
    end
  end

  def show
    @email_confirmation = current_user.email_confirmations.where(confirmation_code: params[:id]).first!
    @email_confirmation.confirm!
    redirect_to account_path(current_user)
  end

  protected

  def email_confirmation_params
    params.require(:email_confirmation).permit(:email)
  end
end
