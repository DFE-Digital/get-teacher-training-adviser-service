require "rails_helper"

RSpec.describe Studying::SecondaryMathsEnglishGrade4, :vcr do
  let(:yes) { build(:studying_secondary_maths_english_grade4) }
  let(:no) { build(:studying_secondary_maths_english_grade4, has_required_subjects: SecondaryMathsEnglishGrade4::OPTIONS[:no]) }

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("studying/subject_interested_teaching")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("studying/retake_english_maths")
      end
    end
  end
end
