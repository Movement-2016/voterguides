class EmailConfirmationMailer < ApplicationMailer
  default from: FROM_ADDRESS

  def confirmation_code(email_confirmation_id)
    @confirmation = EmailConfirmation.find(email_confirmation_id)
    mail(to: @confirmation.email, subject: "Publish your guide with #{SITE_NAME}")
  end
end
