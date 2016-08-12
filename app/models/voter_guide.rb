class VoterGuide < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :endorsements, -> { order(:guide_order) }, dependent: :destroy
  has_many :supporters

  validates :name, presence: true,
            uniqueness: {
              scope: [:target_city, :target_state],
              message: "should be unique for your area"}
  validates :target_state, presence: true
  validates :target_city, presence: true
  validates :election_date, presence: true
  validates :external_guide_url,
            format: { with: /\A#{URI::regexp(['http', 'https'])}\z/,
                      message: "must be a standard Web address",
                      allow_blank: true }

  accepts_nested_attributes_for :endorsements, reject_if: :all_blank, allow_destroy: true

  scope :upcoming, -> { where("election_date >= ?", Date.today)}
  scope :published, -> { where.not(published_at: nil) }
  scope :by_state, ->(state) { where(target_state: state) }
  scope :by_zip, ->(zip) { GeographyPresenter.new(zip).search(VoterGuide) }

  def presenter
    @presenter ||= VoterGuidePresenter.new(self)
  end

  def published?
    published_at?
  end
end
