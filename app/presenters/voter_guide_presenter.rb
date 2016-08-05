require 'delegate'

class VoterGuidePresenter < SimpleDelegator
  def publish_date
    model.published_at.strftime("%B %e, %Y")
  end

  def supporter_text
    return unless supporters.count > 0
    "#{supporters.count} #{'supporter'.pluralize(supporters.count)}"
  end

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

  def show_core_form?
    model.errors.any? || !show_endorsements?
  end

  def model
    __getobj__
  end
end
