class Election < ApplicationRecord
  validates :election_date, presence: true

  scope :upcoming, -> { where("election_date >= ?", Time.now).order(:election_date) }
end
