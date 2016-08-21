class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }, uniqueness: true
end
