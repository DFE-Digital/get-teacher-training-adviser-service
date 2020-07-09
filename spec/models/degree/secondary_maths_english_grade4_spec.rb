require "rails_helper"

RSpec.describe Degree::SecondaryMathsEnglishGrade4 do
  let(:yes) { build(:degree_secondary_maths_english_grade4) }
  let(:no) { build(:degree_secondary_maths_english_grade4, has_required_subjects: SecondaryMathsEnglishGrade4::OPTIONS[:no]) }

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("degree/subject_interested_teaching")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("degree/retake_english_maths")
      end
    end
  end
end
