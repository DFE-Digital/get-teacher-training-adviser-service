require 'rails_helper'

RSpec.describe PrimaryMathsEnglishGrade4 do
  let(:yes) { build(:primary_maths_english_grade4) }
  let(:wrong_answer) { build(:primary_maths_english_grade4, has_required_subjects: 'gibberish') }
  let(:no) { build(:primary_maths_english_grade4, has_required_subjects: false ) }

  describe "validation" do
    it "only accepts true or false values" do
      expect(wrong_answer).to be_valid
      expect(yes).to be_valid
      expect(no).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is true" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("subject_interested_teaching")
      end
    end

    context "when answer is false" do
      it "returns the correct option" do
        expect(no.next_step).to eq("qualification_required")
      end
    end
  end
end
