require "rails_helper"

RSpec.describe PrimaryMathsEnglishGrade4 do
  subject { build(:primary_maths_english_grade4) }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.has_gcse_maths_and_english_id = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end
end
