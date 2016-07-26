class GeographyPresenter
  def self.load_states
    Carmen::Country.named("United States").subregions.reduce([]) do |m, region|
      next m unless  %w[ district state ].include?(region.type)
      m << [region.name, region.code]
      m
    end
  end
  ELIGIBLE_STATES = load_states
end
