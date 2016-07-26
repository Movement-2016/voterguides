class VoterGuidesController < ApplicationController
  before_filter :require_login, except: [:show, :index]
  load_and_authorize_resource

  def new
  end

  def create
    if @voter_guide.save
      redirect_to edit_voter_guide_path(@voter_guide)
    else
      render :new
    end
  end

  def show
  end

  def index
    search = VoterGuide.upcoming
    search = search.by_state(params[:search_state]) if params[:search_state]
    @voter_guides = search
  end

  def edit
  end

  def update
    if @voter_guide.update(voter_guide_params)
      redirect_to edit_voter_guide_path(@voter_guide)
    else
      render :edit
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
