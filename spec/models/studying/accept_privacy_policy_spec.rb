require "rails_helper"

RSpec.describe Studying::AcceptPrivacyPolicy, :vcr do
  subject { build(:studying_accept_privacy_policy) }

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
