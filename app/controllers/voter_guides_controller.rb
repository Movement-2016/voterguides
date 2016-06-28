class VoterGuidesController < ApplicationController
  def new
    @voter_guide = VoterGuide.new
  end

  def create
    @voter_guide = VoterGuide.new(voter_guide_params)
    if @voter_guide.save
      redirect_to new_voter_guide_position_path(@voter_guide)
    else
      render :new
    end
  end

  protected

  def voter_guide_params
    params.require(:voter_guide).permit(:name, :target_city, :target_state, :election_date)
  end
end
