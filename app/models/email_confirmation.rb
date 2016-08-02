class EmailConfirmation < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :confirmation_code, presence: true

  before_validation :generate_confirmation_code, :ensure_email, on: :create

  def ensure_email
    self.email ||= user.email
  end

  def generate_confirmation_code
    self.confirmation_code ||= SecureRandom.hex(16)
  end

  def to_param
    confirmation_code
  end
end
