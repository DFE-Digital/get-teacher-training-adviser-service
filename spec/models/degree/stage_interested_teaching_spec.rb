require 'rails_helper'

RSpec.describe Degree::StageInterestedTeaching do
  let(:primary) { build(:degree_stage_interested_teaching) }
  let(:secondary) { build(:degree_stage_interested_teaching, primary_or_secondary: "secondary") }

  describe "#next_step" do
    context "when answer is primary" do
      it "returns the correct option" do
        expect(primary.next_step).to eq("degree/science_grade4")
      end
    end

    context "when answer is secondary" do
      it "returns the correct option" do
        expect(secondary.next_step).to eq("degree/secondary_maths_english_grade4")
      end
    end
  end
end
