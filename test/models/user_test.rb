require 'test_helper'

describe User do
  let(:user) { create :user }
  describe "#email_confirmed?" do
    describe "with a new voterguide" do
      it "should be false" do
        expect(user.email_confirmed?).must_equal(false)
      end
    end

    describe "after a confirmation message has been sent" do
      before do
        create :email_confirmation, user: user
      end
      it "should be false" do
        expect(user.email_confirmed?).must_equal(false)
      end
    end

    describe "after the user has confirmed email" do
      let(:confirmation) { create :email_confirmation, user: user }
      before do
        confirmation.touch :confirmed_at
      end
      it "should be confirmed" do
        expect(user.email_confirmed?).must_equal(true)
      end
    end
  end
end
