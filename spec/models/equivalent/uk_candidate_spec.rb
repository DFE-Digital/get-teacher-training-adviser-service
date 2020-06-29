require "rails_helper"

RSpec.describe Equivalent::UkCandidate do
  let(:address) { build(:equivalent_uk_candidate) }

  describe "#next_step" do
    it "returns the next step" do
      expect(address.next_step).to eq("equivalent/uk_callback")
    end
  end
end
