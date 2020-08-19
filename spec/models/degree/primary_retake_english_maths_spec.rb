require "rails_helper"

RSpec.describe Degree::PrimaryRetakeEnglishMaths do
  let(:retake_english_maths) { build(:degree_primary_retake_english_maths) }
  let(:no) { build(:degree_primary_retake_english_maths, planning_to_retake_gcse_maths_and_english_id: PrimaryRetakeEnglishMaths::OPTIONS[:no]) }

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(retake_english_maths.next_step).to eq("degree/science_grade4")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("qualification_required")
      end
    end
  end
end
