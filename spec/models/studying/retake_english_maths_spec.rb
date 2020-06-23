require 'rails_helper'

RSpec.describe Studying::RetakeEnglishMaths do
  let(:retake_english_maths) { build(:studying_retake_english_maths) }
  let(:no) { build(:degree_retake_english_maths, retaking_english_maths: false) }


  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(retake_english_maths.next_step).to eq("studying/subject_interested_teaching")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("qualification_required")
      end
    end
  end
end
