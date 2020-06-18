require 'rails_helper'

RSpec.describe Equivalent::StageInterestedTeaching do
  let(:primary) { build(:equivalent_stage_interested_teaching) }
  let(:secondary) { build(:equivalent_stage_interested_teaching, primary_or_secondary: "secondary") }

  describe "#next_step" do
    context "when answer is primary" do
      it "returns the correct option" do
        expect(primary.next_step).to eq("equivalent/subject_interested_teaching")
      end
    end

    context "when answer is secondary" do
      it "returns the correct option" do
        expect(secondary.next_step).to eq("equivalent/subject_interested_teaching")
      end
    end
  end
end
