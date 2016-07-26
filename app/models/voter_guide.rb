class VoterGuide < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :endorsements, -> { order(:guide_order) }, dependent: :destroy

  validates :name, presence: true,
            uniqueness: {
              scope: [:target_city, :target_state],
              message: "should be unique for your area"}
  validates :target_state, presence: true
  validates :target_city, presence: true
  validates :election_date, presence: true

  accepts_nested_attributes_for :endorsements, reject_if: :all_blank, allow_destroy: true

  scope :upcoming, -> { where("election_date >= ?", Date.today)}
  scope :by_state, ->(state) { where(target_state: state) }
end
