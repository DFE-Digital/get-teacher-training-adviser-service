require "rails_helper"

RSpec.describe Equivalent::OverseasCompletion do
  let(:confirmed) { build(:equivalent_overseas_completion) }
  let(:unconfirmed) { build(:equivalent_overseas_completion, confirmed: false) }

  describe "#next_step" do
    context "when confirmed is true" do
      it "returns the correct option" do
        expect(confirmed.next_step).to eq("equivalent/accept_privacy_policy")
      end
    end

    context "when unconfirmed" do
      it "returns nil" do
        expect(unconfirmed.next_step).to eq(nil)
      end
    end
  end
end
