class PasswordReset < ApplicationRecord
  belongs_to :user

  before_validation :connect_user, on: :create
  before_validation :generate_reset_code, on: :create
  validates :reset_code, presence: true
  validates :user_id, presence: true
  validate :user_has_identity

  scope :valid, -> { where("created_at > ?", 1.day.ago).where(reset_at: nil) }

  def connect_user
    self.user ||= User.admissible.where(email: email).first
  end

  def generate_reset_code
    self.reset_code ||= SecureRandom.hex(16)
  end

  def user_has_identity
    return if user and user.identity
    errors.add(:base, "must use password login, provider is #{user ? user.provider : 'not found'}")
  end

  def to_param
    reset_code
  end
end
