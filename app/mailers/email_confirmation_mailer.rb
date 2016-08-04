class EmailConfirmationMailer < ApplicationMailer
  default from: FROM_ADDRESS

  def confirmation_code(email_confirmation_id)
    @confirmation = EmailConfirmation.find(email_confirmation_id)
    @unsubscribe = UnsubscribeOption.verify_or_create_for_user(@confirmation.user)
    mail(to: @confirmation.email, subject: "Publish your guide with #{SITE_NAME}")
  end
end
