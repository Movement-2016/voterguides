require 'delegate'

class EndorsementPresenter < SimpleDelegator
  def summary_text
    if candidate_name?
      "#{candidate_name} for #{item_description}"
    else
      "#{recommendation_text} on #{item_description}"
    end
  end

  def item_description
    description = candidate_name? ? office : initiative
    if description.present? && description.include?(jurisdiction)
      description
    else
      "#{jurisdiction} #{description}"
    end
  end

  def edit_form
    candidate_name? ? 'endorsements/form' : 'endorsements/initiative_form'
  end

  def recommendation_text
    recommendation? ? "YES" : "NO"
  end
end
