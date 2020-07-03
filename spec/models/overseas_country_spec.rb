require "rails_helper"

RSpec.describe OverseasCountry, :vcr do
  let(:country) { build(:overseas_country) }
  let(:big_country) { build(:overseas_country, country_code: "ABC") }

  describe "validation" do
    context "with correct attribute" do
      it "is valid" do
        expect(country).to be_valid
      end
    end

    context "without correct attribute" do
      it "is invalid" do
        expect(big_country).not_to be_valid
      end
    end
  end

  describe "#next_step" do
    it "returns the correct step" do
      expect(country.next_step).to eq("overseas_telephone")
    end
  end
end
