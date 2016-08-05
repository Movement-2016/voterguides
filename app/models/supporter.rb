class Supporter < ApplicationRecord
  belongs_to :user
  belongs_to :voter_guide

  validates :user, presence: true
  validates :voter_guide, presence: true
end
