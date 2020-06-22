require 'rails_helper'

RSpec.describe Equivalent::UkOrOverseas do
  let(:uk) { build(:equivalent_uk_or_overseas) }
  let(:overseas) { build(:equivalent_uk_or_overseas, uk_or_overseas: "overseas") }

  describe "#next_step" do
    context "when answer is uk" do
      it "returns the correct option" do
        expect(uk.next_step).to eq("equivalent/uk_candidate")
      end
    end

    context "when answer is overseas" do
      it "returns the correct option" do
        expect(overseas.next_step).to eq("equivalent/overseas_country")
      end
    end
  end
end
