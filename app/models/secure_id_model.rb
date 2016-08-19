module SecureIdModel
  def self.included(base)
    base.instance_eval do
      before_validation :generate_secure_id, on: :create
      validates :secure_id, presence: true, uniqueness: true
    end
  end

  def generate_secure_id
    self.secure_id = SecureRandom.urlsafe_base64(8)
  end

  def to_param
    secure_id
  end
end
