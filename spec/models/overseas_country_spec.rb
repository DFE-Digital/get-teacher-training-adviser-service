require "rails_helper"

RSpec.describe OverseasCountry do
  subject { build(:overseas_country) }

  describe "validation" do
    context "with correct attribute" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "without correct attribute" do
      it "is invalid" do
        subject.country_id = "ABC"
        expect(subject).not_to be_valid
      end
    end
  end

  describe "#next_step" do
    it "returns the correct step" do
      expect(subject.next_step).to eq("overseas_telephone")
    end
  end
end
