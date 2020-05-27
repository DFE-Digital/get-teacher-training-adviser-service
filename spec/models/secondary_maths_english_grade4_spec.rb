require 'rails_helper'

RSpec.describe SecondaryMathsEnglishGrade4 do
  let(:yes) { build(:secondary_maths_english_grade4) }
  let(:wrong_answer) { build(:secondary_maths_english_grade4, has_required_subjects: "dont know") }
  let(:no) { build(:secondary_maths_english_grade4, has_required_subjects: "no") }

  describe "validation" do
    it "only accepts yes or no" do
      expect(wrong_answer).not_to be_valid
      expect(yes).to be_valid
      expect(no).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("subject_interested_teaching")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("retake_english_maths")
      end
    end
  end
end
