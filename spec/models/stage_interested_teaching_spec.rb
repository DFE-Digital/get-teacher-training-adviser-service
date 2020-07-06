require "rails_helper"

RSpec.describe StageInterestedTeaching, :vcr do
  subject { build(:stage_interested_teaching) }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.primary_or_secondary = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end

  describe "#next_step" do
    let(:secondary) { build(:stage_interested_teaching, primary_or_secondary: "222750001") }

    context "when answer is primary" do
      it "returns the correct option" do
        expect(subject.next_step).to eq("science_grade4")
      end
    end

    context "when answer is secondary" do
      it "returns the correct option" do
        expect(secondary.next_step).to eq("secondary_maths_english_grade4")
      end
    end
  end
end
