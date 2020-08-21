require "rails_helper"

RSpec.describe Equivalent::OverseasCallback do
  let(:candidate_details) { build(:equivalent_overseas_callback) }

  describe "#next_step" do
    it "returns the next step" do
      expect(candidate_details.next_step).to eq("equivalent/overseas_completion")
    end
  end
end
