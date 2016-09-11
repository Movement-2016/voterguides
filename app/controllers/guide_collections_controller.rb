class GuideCollectionsController < ApplicationController
  def index

  end

  def show
    search =
      case params[:id]
      when "featured" then
        VoterGuide.recommended
      when "election" then
        VoterGuide.where(election_date: params[:election_date])
      else
        VoterGuide
      end
    @voter_guides = search.page(params[:page]).per(100).published.order(published_at: :desc)
  end
end
