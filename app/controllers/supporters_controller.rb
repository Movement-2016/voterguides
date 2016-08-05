class SupportersController < ApplicationController
  before_action :require_login

  def create
    @voter_guide = VoterGuide.find params[:voter_guide_id]
    @supporter = @voter_guide.supporters.create! user: current_user
    redirect_to voter_guide_path(@voter_guide)
  end

  def index
    create # for users redirected from login
  end
end
