class GeographyPresenter < Struct.new(:zip)
  def self.load_states
    Carmen::Country.named("United States").subregions.reduce([]) do |m, region|
      next m unless  %w[ district state ].include?(region.type)
      m << [region.name, region.code]
      m
    end
  end
  ELIGIBLE_STATES = load_states

  def search(target_class)
    state_location = Location.where("zipcode ilike ?", "#{zip[0, 4]}%").first
    loc = Location.where("zipcode ilike ?", "#{zip[0, 2]}%")
    target_class.where(target_city: loc.pluck(:city).uniq, target_state: loc.pluck(:state).uniq).or(
      target_class.where(statewide: true, target_state: state_location.state))
  end
end
