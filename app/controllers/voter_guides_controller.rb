class VoterGuidesController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :allow_guide_uploads, except: [:show, :publish, :index]
  load_and_authorize_resource find_by: :secure_id

  def new
    @voter_guide = VoterGuide.new election_date: Election.upcoming.first.try(:election_date)
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
    search = VoterGuide
    search = search.by_zip(params[:search][:zip]) if params[:search] && params[:search][:zip]
    search = search.by_state(params[:search_state]) if params[:search_state]
    search = search.page(params[:page]).per(100).upcoming.published
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

  def publish
    if ENV['REQUIRE_CONFIRMATION_TO_PUBLISH'].blank? || current_user.email_confirmed?
      @voter_guide.touch :published_at
      flash[:notice] = "Guide has been published"
      redirect_to edit_voter_guide_path(@voter_guide)
    else
      confirmation = EmailConfirmation.create! user: current_user
      EmailConfirmationMailer.confirmation_code(confirmation.id).deliver_now
      redirect_to new_email_confirmation_path
    end
  end

  protected

  def voter_guide_params
    params.require(:voter_guide).permit(
      :name, :target_city, :target_state, :election_date, :external_guide_url, :statewide,
      endorsements_attributes:
        [:id, :_destroy,
         :initiative, :recommendation,
         :jurisdiction, :office, :candidate_name, :explanation, :highlight])
  end

  def allow_guide_uploads
    @upload_guide_target ||= UploadTarget.new("uploads")
  end

end
