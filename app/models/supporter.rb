class Supporter < ApplicationRecord
  belongs_to :user
  belongs_to :voter_guide, counter_cache: true

  validates :user, presence: true, uniqueness: {scope: :voter_guide_id, message: "already supports this guide"}
  validates :voter_guide, presence: true
end
