class UnsubscribeOption < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :code, presence: true

  before_validation :generate_code, :ensure_email, on: :create

  def self.verify_or_create_for_user(user)
    existing = UnsubscribeOption.where(user: user, email: user.email).first
    existing || UnsubscribeOption.create!(user: user)
  end

  def ensure_email
    self.email ||= user.email
  end

  def generate_code
    self.code ||= SecureRandom.hex(16)
  end

  def to_param
    code
  end
end
