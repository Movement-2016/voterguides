class UnsubscribesController < ApplicationController
  def show
    @unsubscribe_option = UnsubscribeOption.where(code: params[:id]).first
  end

  def update
    @unsubscribe_option = UnsubscribeOption.where(code: params[:id]).first
    @unsubscribe_option.touch :requested_at
    flash[:notice] = "You have been unsubscribed from future emails"
    redirect_to root_path
  end
end
