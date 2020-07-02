require "rails_helper"

RSpec.describe PreviousSubject, :vcr do
  subject { build(:previous_subject) }

  describe "validation" do
    context "with valid subject option" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "with invalid subject option" do
      it "is not valid" do
        subject.prev_subject = "invalid_id"
        expect(subject).to_not be_valid
      end
    end
  end

  describe "#next_step" do
    context "with valid input" do
      it "returns the correct step" do
        expect(subject.next_step).to eq("subject_like_to_teach")
      end
    end
  end
end
