require 'rails_helper'

RSpec.describe Equivalent::StageInterestedTeaching do
  let(:primary) { build(:equivalent_stage_interested_teaching) }
  let(:wrong_answer) { build(:equivalent_stage_interested_teaching, primary_or_secondary: "dont know") }
  let(:secondary) { build(:equivalent_stage_interested_teaching, primary_or_secondary: "secondary") }

  describe "validation" do
    it "only accepts primary or secondary" do
      expect(wrong_answer).not_to be_valid
      expect(primary).to be_valid
      expect(secondary).to be_valid
    end
  end

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
