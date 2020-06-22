require 'rails_helper'

RSpec.describe Degree::UkOrOverseas do
  let(:uk) { build(:degree_uk_or_overseas) }
  let(:wrong_answer) { build(:degree_uk_or_overseas, uk_or_overseas: "dont know") }
  let(:overseas) { build(:degree_uk_or_overseas, uk_or_overseas: "overseas") }

  describe "validation" do
    it "only accepts uk or overseas" do
      expect(wrong_answer).not_to be_valid
      expect(uk).to be_valid
      expect(overseas).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is uk" do
      it "returns the correct option" do
        expect(uk.next_step).to eq("degree/uk_candidate")
      end
    end

    context "when answer is overseas" do
      it "returns the correct option" do
        expect(overseas.next_step).to eq("degree/overseas_country")
      end
    end
  end
end
