namespace :sample_data do
  desc "generate sample voter guides for testing"
  task populate: :environment do
    require './test/support/factory_girl.rb'
    @users = []
    @voter_guides = []
    5.times do
      @users << FactoryGirl.create(:user, name: Faker::Name.name)
    end
    20.times do
      @voter_guides << FactoryGirl.create(:voter_guide, :with_endorsements, :published, author: @users[rand(5)], recommended_at: (Date.today if rand(10) == 0))
    end

  end

  desc "drop sample voter guides used for testing"
  task obliterate: :environment do
    sample_users = User.where("email similar to ?", 'doe\d+@example.com')
    sample_users.each do |user|
      user.authored_voter_guides.destroy_all
    end
  end
end
