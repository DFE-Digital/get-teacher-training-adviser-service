require 'rails_helper'

RSpec.describe StageInterestedTeaching do
  let(:primary) { build(:stage_interested_teaching) }
  let(:maths) { build(:stage_interested_teaching, primary_or_secondary: "primary with maths") }
  let(:wrong_answer) { build(:stage_interested_teaching, primary_or_secondary: "dont know") }
  let(:secondary) { build(:stage_interested_teaching, primary_or_secondary: "secondary") }

  describe "validation" do
    it "only accepts primary, primary with maths or secondary" do
      expect(wrong_answer).not_to be_valid
      expect(primary).to be_valid
      expect(maths).to be_valid
      expect(secondary).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is primary" do
      it "returns the correct option" do
        expect(primary.next_step).to eq("science_grade4")
      end
    end

    context "when answer is primary with maths" do
      it "returns the correct option" do
        expect(maths.next_step).to eq("science_grade4")
      end
    end

    context "when answer is secondary" do
      it "returns the correct option" do
        expect(secondary.next_step).to eq("secondary_maths_english_grade4")
      end
    end
  end
end
