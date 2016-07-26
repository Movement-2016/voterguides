namespace :manage do
  # to use this: rake manage:declare_admin[user@example.com]
  desc "declare a user with a given email to be an admin"
  task :declare_admin, [:target_email] => :environment do |t, args|
    user = User.where(email: args["target_email"]).first!
    user.update_attribute :admin, true
  end
end
