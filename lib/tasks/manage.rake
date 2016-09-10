namespace :manage do
  class Router
    include Rails.application.routes.url_helpers

    def self.default_url_options
      ActionMailer::Base.default_url_options
    end
  end

  # to use this: rake manage:declare_admin[user@example.com]
  desc "declare a user with a given email to be an admin"
  task :declare_admin, [:target_email] => :environment do |t, args|
    user = User.where(email: args["target_email"]).first!
    user.update_attribute :admin, true
  end

  desc "create a reset password link for a given user"
  task :reset_password, [:target_email] => :environment do |t, args|
    user = User.where(email: args["target_email"]).first!
    pw_link = PasswordReset.create!(user: user)
    puts Router.new.password_reset_url(pw_link)
  end
end
