require 'test_helper'

describe SessionsController do
  describe "#create" do
    it "should redirect to root and logs in the user" do
      @request.env["omniauth.auth"] = { "uid" => "12345", "info" => {} }
      user = create :user, auth_hash: { uid: "12345", "info" => {}}
      post :create
      assert_redirected_to(root_path)
      expect(flash[:alert]).must_be_nil
    end

    describe "when the user has been suspended" do
      it "should redirect to root without logging in the user" do
        @request.env["omniauth.auth"] = { "uid" => "12345", "info" => {} }
        user = create :user, auth_hash: { uid: "12345", "info" => {}}, suspended_at: Time.now
        post :create
        assert_redirected_to(root_path)
        expect(flash[:alert]).must_match(/suspended/)
      end
    end
  end
end
