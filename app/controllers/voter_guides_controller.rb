class VoterGuidesController < ApplicationController
  def new
    @voter_guide = VoterGuide.new
  end

  def create
    @voter_guide = VoterGuide.new(voter_guide_params)
    if @voter_guide.save
      redirect_to voter_guide_path(@voter_guide)
    else
      render :new
    end
  end

  def show
    @voter_guide = VoterGuide.find(params[:id])

  end

  def update
    @voter_guide = VoterGuide.find(params[:id])
    if @voter_guide.update(voter_guide_params)
      redirect_to voter_guide_path(@voter_guide)
    else
      render @show
    end
  end

  protected

  def voter_guide_params
    params.require(:voter_guide).permit(
      :name, :target_city, :target_state, :election_date,
      endorsements_attributes:
        [:id, :jurisdiction, :office, :candidate_name, :explanation, :highlight, :_destroy])
  end
end
