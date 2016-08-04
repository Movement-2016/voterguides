require 'test_helper'

describe UnsubscribeOption do
  let(:user) { create :user }

  describe "when created with a user" do
    let(:option) { UnsubscribeOption.create user: user}
    it "should fill in the email" do
      value(option.email).must_equal(user.email)
    end

    it "should create a secure code" do
      value(option.code).wont_be_nil
    end
  end
end
