require "rails_helper"

RSpec.describe StageInterestedTeaching, :vcr do
  subject { build(:stage_interested_teaching) }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.primary_or_secondary = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end
end
