class Endorsement < ApplicationRecord
  belongs_to :voter_guide

  validates :office, presence: true
  validates :candidate_name, presence: true

  scope :highlighted, -> { where(highlight: true)}
end
