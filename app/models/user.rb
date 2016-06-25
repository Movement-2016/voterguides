class User < ApplicationRecord
  before_validation :update_uid
  validates :uid, presence: true, uniqueness: true

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
end
