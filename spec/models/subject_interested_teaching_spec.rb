require "rails_helper"

RSpec.describe SubjectInterestedTeaching, :vcr do
  subject { build(:subject_interested_teaching) }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.preferred_teaching_subject_id = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(subject.next_step).to eq("start_teacher_training")
    end
  end
end
