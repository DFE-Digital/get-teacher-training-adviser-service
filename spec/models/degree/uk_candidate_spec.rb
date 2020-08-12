require "rails_helper"

RSpec.describe Degree::UkCandidate do
  let(:address) { build(:degree_uk_candidate) }
  let(:no_address_line1) { build(:degree_uk_candidate, address_line1: "") }

  describe "#next_step" do
    it "returns the next step" do
      expect(address.next_step).to eq("degree/uk_telephone")
    end
  end
end
