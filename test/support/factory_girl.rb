require 'csv'

FactoryGirl.define do
  sequence :current_order
  sequence :current_location do
    FakeLocation.new
  end
  sequence :current_office do
    office = FakeVoterGuide::OFFICES.sample
    location = FakeLocation.new
    FakeOffice.new(location, *office)
  end

  factory :user do
    name { "Juan Doe #{generate(:current_order)}" }
    email { "doe#{generate(:current_order)}@example.com" }
    auth_hash { { uid: SecureRandom.hex(10), info: {}}}

    factory :author do
      email { "author#{generate(:current_order)}@example.com" }
    end
  end

  factory :voter_guide do
    transient { current_location }
    name { FakeVoterGuide::TITLES.sample % current_location.city }
    target_city { current_location.city }
    target_state { current_location.state }
    election_date { 3.months.from_now }

    trait :with_endorsements do
      after(:create) do |guide|
        create_list :endorsement, rand(7)+3, voter_guide: guide
      end
    end

    trait :with_author do
      author
    end
  end

  factory :endorsement do
    transient { current_office }
    office { current_office.name }
    jurisdiction { current_office.jurisdiction }
    explanation { Faker::Lorem.paragraphs(rand(3) + 1).join("\n\n")}
    highlight { rand(5) == 0 }
    candidate_name { Faker::Name.name }
    guide_order { rand(10000) }
  end
end

class FakeVoterGuide
  TITLES = [
    "Concerned Citizens of %s Guide",
    "Teacher's League of %s Guide",
    "Outreach Committee for %s Guide",
    "Last %s Guide You'll Ever Need",
    "Real Opinions Guide to %s Elections",
    "Give No F*s Guide",
    "Left of Green %s Guide"
  ]

  OFFICES = [
    ["United States Senator", :state],
    ["State Senator", :district],
    ["Member of the State Assembly", :district],
    ["Superior Court Judge", :county],
    ["County Board of Supervisors", :county],
    ["County Board of Education", :county],
    ["Sanitary District", :county],
    ["Flood Control District", :district],
    ["City Council", :city]
  ]
end

class FakeLocation < Struct.new(:zip, :city, :county, :state)
  cattr_accessor :locations

  def self.load_locations
    self.locations = []
    CSV.foreach(Rails.root.join('test/support/geo/zips.csv')) do |row|
      if rand(100) == 0
        self.locations << row
      end
    end
  end

  def initialize
    FakeLocation.load_locations unless FakeLocation.locations
    super(*FakeLocation.locations.sample)
  end
end

class FakeOffice < Struct.new(:location, :position, :polity)
  def name
    "#{position}, #{jurisdiction}"
  end

  def jurisdiction
    case polity
    when :district
      "District #{district}"
    when :city
      "City of #{location.city}"
    when :county
      "#{location.county} County"
    when :state
      "State of #{location.state}"
    end
  end

  def district
    @district ||= rand(25) + 1
  end

end
