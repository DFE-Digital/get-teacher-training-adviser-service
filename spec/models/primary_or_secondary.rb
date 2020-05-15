require 'rails_helper'

RSpec.describe PrimaryOrSecondary do
  let(:primary) { build(:primary_or_secondary) }
  let(:wrong_answer) { build(:primary_or_secondary, primary_or_secondary: "dont know") }
  let(:secondary) { build(:primary_or_secondary, primary_or_secondary: "secondary") }

  describe "validation" do
    it "only accepts primary or secondary" do
      expect(wrong_answer).not_to be_valid
      expect(primary).to be_valid
      expect(secondary).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is primary" do
      it "returns the correct option" do
        expect(primary.next_step).to eq("primaryy")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(secondary.next_step).to eq("secondary")
      end
    end
  end
end
