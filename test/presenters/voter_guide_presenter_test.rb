require 'test_helper'

describe VoterGuidePresenter do
  let(:presenter) { VoterGuidePresenter.new(voter_guide) }
  let(:voter_guide) { create(:voter_guide) }
  describe "#show_url" do
    it "returns the internal voter guide path" do
      presenter.show_url.must_match(/\/voter_guides\/.{3}/)
    end

    describe "when initialized with an external_guide_url" do
      let(:voter_guide) { create(:voter_guide, external_guide_url: "http://example.com") }
      it "returns the field value" do
        presenter.show_url.must_equal "http://example.com"
      end
    end

  end
end
