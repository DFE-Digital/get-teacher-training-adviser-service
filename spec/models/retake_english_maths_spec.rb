require "rails_helper"

RSpec.describe RetakeEnglishMaths, :vcr do
  subject { build(:retake_english_maths) }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.retaking_english_maths = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end
end
