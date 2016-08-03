require 'test_helper'

describe Endorsement do
  let(:guide) { create :voter_guide }
  describe "when created with a candidate" do
    it "is valid" do
      expect(guide.endorsements.build(candidate_name:"Bob", office: "Mayor")).must_be :valid?
    end
  end

  describe "when created without a candidate" do
    let(:endorsement) { guide.endorsements.build(office: "Mayor") }
    it "is not valid" do
      expect(endorsement).wont_be :valid?
      p endorsement.errors.full_messages.join
    end
  end

  describe "when created with a ballot initiative" do
    it "is valid" do
      expect(guide.endorsements.build(initiative:"Measure Z", recommendation: true)).must_be :valid?
    end
  end
end
