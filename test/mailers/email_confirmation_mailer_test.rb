require 'test_helper'

describe EmailConfirmationMailer do
  let(:user) { create :user }
  let(:confirmation) { EmailConfirmation.create! user: user }
  let(:email) { EmailConfirmationMailer.confirmation_code(confirmation.id) }

  describe "#confirmation_code" do
    it "creates an unsubscribe option and tells the user about it" do
      assert_emails 1 do
        email.deliver_now
      end

      expect(user.unsubscribe_options.count).must_equal(1)
      expect(email.parts[0].body.to_s).must_match /To unsubscribe/
    end

    describe "when the user has already received an email" do
      it "does not create a new unsubscribe option" do
        email.deliver_now
        email2 = EmailConfirmationMailer.confirmation_code(confirmation.id)
        email2.deliver_now
        expect(user.reload.unsubscribe_options.count).must_equal(1)
      end
    end

    describe "when the target user has unsubscribed" do
      it "does not send an email" do
        email
        option = UnsubscribeOption.create(user: user, requested_at: Time.now)
        assert_emails 0 do
          email.deliver_now
        end
      end
    end
  end
end
