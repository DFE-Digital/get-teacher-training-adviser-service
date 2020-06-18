require 'rails_helper'

RSpec.describe PreviousSubject, :vcr do
  subject { build(:previous_subject) }

  describe "#prev_subject" do
    it "validates" do
      subject.prev_subject = 'invalid-id'
      expect(subject).to_not be_valid
      subject.prev_subject = nil
      expect(subject).to_not be_valid
      subject.prev_subject = '6b793433-cd1f-e911-a979-000d3a20838a'
      expect(subject).to be_valid
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