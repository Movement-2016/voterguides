class VoterGuidesController < ApplicationController
  before_action :require_login, :allow_guide_uploads, except: [:show, :index]
  load_and_authorize_resource

  def new
    @voter_guide = VoterGuide.new
  end

  def create
    @voter_guide = VoterGuide.new(voter_guide_params.merge(author: current_user))
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
      :name, :target_city, :target_state, :election_date, :external_guide_url,
      endorsements_attributes:
        [:id, :jurisdiction, :office, :candidate_name, :explanation, :highlight, :_destroy])
  end

  def allow_guide_uploads
    @upload_guide_target ||= S3_BUCKET.presigned_post(
      key: "uploads/#{SecureRandom.uuid}/${filename}",
      success_action_status: '201',
      acl: 'public-read')
  end

end
