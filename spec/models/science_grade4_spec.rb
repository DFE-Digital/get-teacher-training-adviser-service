require "rails_helper"

RSpec.describe ScienceGrade4 do
  let(:science_grade4) { build(:science_grade4) }
  let(:wrong_answer) { build(:science_grade4, have_science: "dont know") }
  let(:new_teacher) { build(:science_grade4, have_science: "no") }

  describe "validation" do
    it "only accepts yes or no" do
      expect(wrong_answer).not_to be_valid
      expect(science_grade4).to be_valid
      expect(new_teacher).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(science_grade4.next_step).to eq("primary_maths_english_grade4")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(new_teacher.next_step).to eq("qualification_required")
      end
    end
  end
end
