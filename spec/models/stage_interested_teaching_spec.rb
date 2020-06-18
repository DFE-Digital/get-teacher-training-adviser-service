require 'rails_helper'

RSpec.describe StageInterestedTeaching, :vcr do
  subject { build(:stage_interested_teaching) }

  describe "#primary_or_secondary" do
    it "validates" do
      subject.primary_or_secondary = 'invalid-id'
      expect(subject).to_not be_valid
      subject.primary_or_secondary = described_class::STAGES[:primary]
      expect(subject).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is not secondary" do
      it "returns the correct option" do
        subject.primary_or_secondary = described_class::STAGES[:primary]
        expect(subject.next_step).to eq("science_grade4")
      end
    end

    context "when answer is secondary" do
      it "returns the correct option" do
        subject.primary_or_secondary = described_class::STAGES[:secondary]
        expect(subject.next_step).to eq("secondary_maths_english_grade4")
      end
    end
  end
end
