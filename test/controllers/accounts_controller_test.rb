require 'test_helper'

describe AccountsController do
  describe "GET #show" do
    let(:user) { create :user }
    def action
      get :show, params: { id: user.id }, session: { current_user_id: user.id }
    end
    it "loads the requested user" do
      action
      expect(assigns(:account)).must_equal(user)
    end
  end
end
