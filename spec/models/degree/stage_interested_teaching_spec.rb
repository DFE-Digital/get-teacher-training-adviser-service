require "rails_helper"

RSpec.describe Degree::StageInterestedTeaching, :vcr do
  subject { build(:degree_stage_interested_teaching) }
  let(:secondary) { build(:degree_stage_interested_teaching, primary_or_secondary: "222750001") }

  describe "#next_step" do
    context "when answer is primary with maths" do
      it "returns the correct option" do
        expect(subject.next_step).to eq("degree/primary_maths_english_grade4")
      end
    end

    context "when answer is secondary" do
      it "returns the correct option" do
        expect(secondary.next_step).to eq("degree/secondary_maths_english_grade4")
      end
    end
  end
end
