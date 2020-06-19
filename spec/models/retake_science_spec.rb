require 'rails_helper'

RSpec.describe RetakeScience do
  let(:retake_science) { build(:retake_science) }
  let(:wrong_answer) { build(:retake_science, retaking_science: 'gibberish') }
  let(:no) { build(:retake_science, retaking_science: false) }

  describe "validation" do
    it "only accepts true or false" do
      expect(retake_science).to be_valid
      expect(no).to be_valid
      expect(wrong_answer).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(retake_science.next_step).to eq("start_teacher_training")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("qualification_required")
      end
    end
  end
end
