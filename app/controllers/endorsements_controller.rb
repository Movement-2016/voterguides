class EndorsementsController < ApplicationController
  def new
    @endorsement = voter_guide.endorsements.build
  end

  protected

  def voter_guide
    @voter_guide ||= VoterGuide.find params[:voter_guide_id]
  end
end
