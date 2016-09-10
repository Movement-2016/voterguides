class PasswordResetMailer< ApplicationMailer
  default from: FROM_ADDRESS

  def reset_password(password_reset_id)
    @password_reset = PasswordReset.find(password_reset_id)
    @unsubscribe = UnsubscribeOption.verify_or_create_for_user(@password_reset.user)
    mail(to: @password_reset.user.email, subject: "Reset your password for #{SITE_NAME}")
  end
end
