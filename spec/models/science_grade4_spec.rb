require "rails_helper"

RSpec.describe ScienceGrade4, :vcr do
  subject { build(:science_grade4) }
  let(:no) { build(:science_grade4, have_science: "222750000") }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.have_science = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end
end
