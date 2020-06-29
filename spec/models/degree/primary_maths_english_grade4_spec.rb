require "rails_helper"

RSpec.describe Degree::PrimaryMathsEnglishGrade4 do
  let(:yes) { build(:degree_primary_maths_english_grade4) }
  let(:no) { build(:degree_primary_maths_english_grade4, has_required_subjects: false) }

  describe "#next_step" do
    context "when answer is true" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("degree/science_grade4")
      end
    end

    context "when answer is false" do
      it "returns the correct option" do
        expect(no.next_step).to eq("degree/primary_retake_english_maths")
      end
    end
  end
end
