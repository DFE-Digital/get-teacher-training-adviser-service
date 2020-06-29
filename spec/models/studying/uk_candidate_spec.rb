require "rails_helper"

RSpec.describe Studying::UkCandidate do
  let(:address) { build(:studying_uk_candidate) }

  describe "#next_step" do
    it "returns the next step" do
      expect(address.next_step).to eq("studying/uk_telephone")
    end
  end
end
