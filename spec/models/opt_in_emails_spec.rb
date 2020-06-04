require 'rails_helper'

RSpec.describe OptInEmails do
  let(:confirmed) { build(:opt_in_emails) }
  let(:unconfirmed) { build(:opt_in_emails, email: 'no') }
  let(:wrong_answer) { build(:opt_in_emails, email: 'yiuyi') }

  describe "validation" do
    it "only accepts yes or no answers" do
      expect(wrong_answer).not_to be_valid
      expect(unconfirmed).to be_valid
      expect(confirmed).to be_valid
    end
  end

  describe "#next_step" do
    context "when confirmed is true" do
      it "returns the correct option" do
        expect(confirmed.next_step).to eq("accept_privacy_policy")
      end
    end

    context "when unconfirmed" do
      it "returns the correct option" do
        expect(unconfirmed.next_step).to eq("accept_privacy_policy")
      end
    end
  end
end
