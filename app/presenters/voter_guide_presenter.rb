require 'delegate'

class VoterGuidePresenter < SimpleDelegator
  def publish_date
    model.published_at.strftime("%B %e, %Y")
  end

  def location_and_description_text
    ["#{target_city}, #{target_state}", description_text].select(&:present?).join(" &mdash; ")
  end

  def description_text
    return model.description if model.description.present?
    endorsements.highlighted.limit(3).map { |e| e.presenter.summary_text }.join(' &bullet; ')
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
