require 'test_helper'

describe VoterGuidesController do
  let(:voter_guide) { create(:voter_guide, :with_author) }
  describe "#publish" do
    subject do
      patch :publish, params: { id: voter_guide.id }
    end

    describe "when the owner is not logged in" do
      before do
        session[:current_user_id] = create(:user).id
      end
      it "ignores this" do
        subject
        value(voter_guide.published_at).must_be_nil
      end
    end

    describe "when the owner is logged in but not confirmed" do
      before do
        ENV['REQUIRE_CONFIRMATION_TO_PUBLISH']='1'
        # skip('waiting for email confirmation flag to be removed')
        session[:current_user_id] = voter_guide.author_id
      end

      it "redirects" do
        value(voter_guide.published_at).must_be_nil
        subject
        assert_redirected_to new_email_confirmation_path
      end

      it "creates a new confirmation" do
        old_count = EmailConfirmation.count
        subject
        value(EmailConfirmation.count).must_equal(old_count + 1)
      end

      it "sends an email" do
        assert_emails 1 do
          subject
        end
      end
    end

    describe "when the owner is logged in with a confirmed email address" do
      before do
        create :email_confirmation, :confirmed, user: voter_guide.author
        session[:current_user_id] = voter_guide.author_id
      end

      it "publishes the guide" do
        value(voter_guide.published_at).must_be_nil
        subject
        value(voter_guide.reload.published_at).must_be_close_to(Time.now, 2.seconds)
      end
    end
  end
end
