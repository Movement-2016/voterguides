class User < ApplicationRecord
  include SecureIdModel

  validates :uid, presence: true, uniqueness: { scope: :provider }

  has_many :authored_voter_guides, class_name: 'VoterGuide', foreign_key: 'author_id'
  has_many :supporters, dependent: :destroy
  has_many :supported_voter_guides, through: :supporters, source: :voter_guide, class_name: 'VoterGuide'
  has_many :email_confirmations, dependent: :destroy
  has_many :unsubscribe_options, dependent: :destroy

  scope :alpha, -> { order("LOWER(name)") }
  scope :admin, -> { where(admin: true)}
  scope :suspended, -> { where.not(suspended_at: nil) }
  scope :admissible, -> { where(suspended_at: nil) }

  class << self
    def find_or_create_from_auth_hash!(auth_hash)
      where(uid: auth_hash['uid'], provider: auth_hash['provider']).first_or_create!(
        auth_hash["info"].slice("name", "email", "image").merge(auth_hash: auth_hash)
      )
    end
  end

  def email_confirmed?
    email_confirmations.where(email: email).where.not(confirmed_at: nil).any?
  end

  def supports?(voter_guide)
    supported_voter_guides.where(id: voter_guide.id).any?
  end

  def suspended?
    suspended_at?
  end

  def identity
    return unless provider == 'identity'
    @identity ||= Identity.find(uid)
  end
end
