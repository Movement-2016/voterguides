require 'delegate'

class VoterGuidePresenter < SimpleDelegator
  def show_url
    if model.external_guide_url.present?
      model.external_guide_url
    else
      Rails.application.routes.url_helpers.voter_guide_path(model)
    end
  end

  def show_endorsements?
    model.external_guide_url.blank?
  end

  def model
    __getobj__
  end
end
