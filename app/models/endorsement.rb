class Endorsement < ApplicationRecord
  include RankedModel

  belongs_to :voter_guide

  validates :voter_guide, presence: true
  validates :office, presence: true, unless: :initiative?
  validates :candidate_name, presence: true, unless: :initiative?
  validates :initiative, presence: true, unless: :candidate_name?

  scope :highlighted, -> { where(highlight: true)}
  ranks :guide_order, with_same: :voter_guide_id

  def presenter
    @presenter ||= EndorsementPresenter.new(self)
  end
end
