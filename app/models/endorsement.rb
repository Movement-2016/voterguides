class Endorsement < ApplicationRecord
  include RankedModel

  belongs_to :voter_guide

  validates :office, presence: true
  validates :candidate_name, presence: true

  scope :highlighted, -> { where(highlight: true)}
  ranks :guide_order, with_same: :voter_guide_id

  def summary_text
    "#{candidate_name} for #{jurisdiction} #{office}"
  end
end
