class VoterGuide < ApplicationRecord

  STATES = %w[ AL AK AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MT MS NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY]
  belongs_to :author, class_name: "User"
  has_many :endorsements, dependent: :destroy

  validates :name, presence: true,
            uniqueness: {
              scope: [:target_city, :target_state],
              message: "should be unique for your area"}
  validates :target_state, presence: true
  validates :target_city, presence: true
  validates :election_date, presence: true

  accepts_nested_attributes_for :endorsements, reject_if: :all_blank, allow_destroy: true

  scope :upcoming, -> { where("election_date >= ?", Date.today)}
end
