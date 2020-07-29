require "rails_helper"

RSpec.describe AcceptPrivacyPolicy, :vcr do
  subject { build(:accept_privacy_policy) }

  describe "validation" do
    context "with required attributes" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "without required attributes" do
      it "is invalid" do
        subject.accepted_policy_id = "invalid_id"
        expect(subject).not_to be_valid
      end
    end
  end

  describe "#next_step" do
    context "with required attribute" do
      it "returns the correct option" do
        expect(subject.next_step).to eq("complete_application")
      end
    end

    context "without required attributes" do
      it "returns nil" do
        subject.accepted_policy_id = "invalid_id"
        expect(subject.next_step).to be(nil)
      end
    end
  end
end
