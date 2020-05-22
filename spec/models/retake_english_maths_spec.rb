require 'rails_helper'

RSpec.describe RetakeEnglishMaths do
  let(:retake_english_maths) { build(:retake_english_maths) }
  let(:wrong_answer) { build(:retake_english_maths, retaking: "dont know") }
  let(:no) { build(:retake_english_maths, retaking: "no") }

  describe "validation" do
    it "only accepts yes or no" do
      expect(wrong_answer).not_to be_valid
      expect(retake_english_maths).to be_valid
      expect(no).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(retake_english_maths.next_step).to eq("subject_interested_teaching")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("qualification_required")
      end
    end
  end
end
