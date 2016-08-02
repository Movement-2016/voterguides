require 'test_helper'

describe EmailConfirmation do
  describe "on create" do
    let(:user) { create(:user) }
    let(:confirmation) { EmailConfirmation.new user: user }

    it "should copy the user's email" do
      confirmation.save
      value(confirmation.email).must_equal(user.email)
    end

    it "should have a confirmation_code" do
      confirmation.save
      value(confirmation.confirmation_code).wont_be_nil
    end
  end
end
