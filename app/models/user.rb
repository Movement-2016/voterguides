class User < ApplicationRecord
  before_validation :update_uid
  validates :uid, presence: true, uniqueness: true

  has_many :authored_voter_guides, class_name: 'VoterGuide', foreign_key: 'author_id'
  has_many :email_confirmations, dependent: :destroy

  class << self
    def find_or_create_from_auth_hash!(auth_hash)
      where(uid: pull_uid(auth_hash)).first_or_create!(
        auth_hash["info"].slice("name", "email", "image").merge(auth_hash: auth_hash)
      )
    end

    def pull_uid(auth_hash)
      auth_hash["info"]["email"] || auth_hash["uid"]
    end
  end

  def update_uid
    self.uid = User.pull_uid(self.auth_hash)
  end

  def email_confirmed?
    email_confirmations.where(email: email).where.not(confirmed_at: nil).any?
  end
end
