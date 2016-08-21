Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['FACEBOOK_KEY']
    provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  end

  provider :identity, :fields => [:name, :email],
           :on_failed_registration => RegistrationsController.action(:new),
           :on_failed_login => SessionsController.action(:new)

  if Rails.env.development?
    provider :developer
  end
end
