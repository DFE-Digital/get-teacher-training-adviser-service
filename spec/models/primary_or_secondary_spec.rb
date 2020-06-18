require 'rails_helper'

RSpec.describe PrimaryOrSecondary, :vcr do
  subject { build(:primary_or_secondary) }

  describe "#primary_or_secondary" do
    it "validates" do
      subject.primary_or_secondary = 'invalid-id'
      expect(subject).to_not be_valid
      subject.primary_or_secondary = described_class::STAGES[:primary]
      expect(subject).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is primary" do
      it "returns the correct option" do
        subject.primary_or_secondary = described_class::STAGES[:primary]
        expect(subject.next_step).to eq("qualified_to_teach")
      end
    end

    context "when answer is secondary" do
      it "returns the correct option" do
        subject.primary_or_secondary = described_class::STAGES[:secondary]
        expect(subject.next_step).to eq("qualified_to_teach")
      end
    end
  end
end
