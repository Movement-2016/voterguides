require 'test_helper'

describe VoterGuidesController do
  let(:voter_guide) { create(:voter_guide, :with_author) }
  describe "#publish" do
    describe "when the owner is not logged in" do
      before do
        session[:current_user_id] = create(:user).id
      end
      it "ignores this" do
        patch :publish, params: { id: voter_guide.id }
        value(voter_guide.published_at).must_be_nil
      end
    end

    describe "when the owner is logged in" do
      before do
        session[:current_user_id] = voter_guide.author_id
      end
      it "publishes the guide" do
        value(voter_guide.published_at).must_be_nil
        patch :publish, params: { id: voter_guide.id }
        value(voter_guide.reload.published_at).must_be_close_to(Time.now, 2.seconds)
      end
    end
  end
end

