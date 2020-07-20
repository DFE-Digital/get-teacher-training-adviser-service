require "rails_helper"

RSpec.describe AcceptPrivacyPolicy do
  let(:confirmed) { build(:accept_privacy_policy) }
  let(:unconfirmed) { build(:accept_privacy_policy, accepted: false) }
  let(:wrong_answer) { build(:accept_privacy_policy, accepted: nil) }

  describe "validation" do
    it "only accepts true values" do
      expect(wrong_answer).not_to be_valid
      expect(unconfirmed).not_to be_valid
      expect(confirmed).to be_valid
    end
  end

  describe "#next_step" do
    context "when confirmed is true" do
      it "returns the correct option" do
        expect(confirmed.next_step).to eq("complete_application")
      end
    end

    context "when unconfirmed" do
      it "returns the correct option" do
        expect(unconfirmed.next_step).to be(nil)
      end
    end
  end
end
