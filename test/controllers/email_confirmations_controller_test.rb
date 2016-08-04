require 'test_helper'

describe EmailConfirmationsController do
  describe "GET #show" do
    let(:user) { create(:user) }
    let(:confirmation) { EmailConfirmation.create! user: user, email: "alternative_email@example.com" }
    subject do
      get :show, params: { id: confirmation.confirmation_code }, session: { current_user_id: user.to_param }
    end

    it "should mark the email as confirmed" do
      subject
      value(confirmation.reload.confirmed_at).must_be_close_to(Time.now, 2.seconds)
    end

    it "should update the user's email to match the confirmed email address" do
      subject
      value(user.reload.email).must_equal(confirmation.email)
    end

    it "should redirect to a list of the users guides" do
      subject
      assert_redirected_to account_path(user)
    end
  end
end
