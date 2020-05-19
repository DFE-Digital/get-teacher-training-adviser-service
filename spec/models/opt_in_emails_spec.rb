require 'rails_helper'

RSpec.describe OptInEmails do
  let(:confirmed) { build(:opt_in_emails) }
  let(:unconfirmed) { build(:opt_in_emails, confirmed: false) }
  let(:wrong_answer) { build(:opt_in_emails, confirmed: nil) }

  describe "validation" do
    it "only accepts true or false values" do
      expect(wrong_answer).not_to be_valid
      expect(unconfirmed).to be_valid
      expect(confirmed).to be_valid
    end
  end

  describe "#next_step" do
    context "when confirmed is true" do
      it "returns the correct option" do
        expect(confirmed.next_step).to eq("privacy_policy")
      end
    end

    context "when unconfirmed" do
      it "returns nil" do
        expect(unconfirmed.next_step).to eq(nil)
      end
    end
  end
end
