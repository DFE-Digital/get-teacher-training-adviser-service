require "rails_helper"

RSpec.describe SubjectLikeToTeach do
  subject { build(:subject_like_to_teach) }

  describe "validation" do
    context "with invalid subject options" do
      %w[skiing fishing golfing surfing].each do |invalid_subject|
        it "is not valid" do
          expect(build(:subject_like_to_teach, preferred_teaching_subject_id: invalid_subject)).to_not be_valid
        end
      end
    end

    context "with valid subject options" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end
  end

  describe "#next_step" do
    it "returns the correct step" do
      expect(subject.next_step).to eq("date_of_birth")
    end
  end
end
