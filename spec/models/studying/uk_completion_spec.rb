require "rails_helper"

RSpec.describe Studying::UkCompletion do
  let(:confirmed) { build(:studying_uk_completion) }
  let(:unconfirmed) { build(:studying_uk_completion, confirmed: false) }

  describe "#next_step" do
    context "when confirmed is true" do
      it "returns the correct option" do
        expect(confirmed.next_step).to eq("studying/accept_privacy_policy")
      end
    end

    context "when unconfirmed" do
      it "returns nil" do
        expect(unconfirmed.next_step).to be(nil)
      end
    end
  end
end
