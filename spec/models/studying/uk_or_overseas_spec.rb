require "rails_helper"

RSpec.describe Studying::UkOrOverseas do
  let(:uk) { build(:studying_uk_or_overseas) }
  let(:overseas) { build(:studying_uk_or_overseas, uk_or_overseas: "222750001") }

  describe "#next_step" do
    context "when answer is uk" do
      it "returns the correct option" do
        expect(uk.next_step).to eq("studying/uk_candidate")
      end
    end

    context "when answer is overseas" do
      it "returns the correct option" do
        expect(overseas.next_step).to eq("studying/overseas_country")
      end
    end
  end
end
