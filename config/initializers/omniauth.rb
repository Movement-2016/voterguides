Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['FACEBOOK_KEY']
    provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  end
  if Rails.env.development?
    provider :developer
  end
end
