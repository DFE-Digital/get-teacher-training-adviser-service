require "rails_helper"

RSpec.describe Studying::PrimaryMathsEnglishGrade4 do
  let(:yes) { build(:studying_primary_maths_english_grade4) }
  let(:no) { build(:studying_primary_maths_english_grade4, has_gcse_maths_and_english_id: PrimaryMathsEnglishGrade4::OPTIONS[:no]) }

  describe "#next_step" do
    context "when answer is true" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("studying/science_grade4")
      end
    end

    context "when answer is false" do
      it "returns the correct option" do
        expect(no.next_step).to eq("studying/primary_retake_english_maths")
      end
    end
  end
end
