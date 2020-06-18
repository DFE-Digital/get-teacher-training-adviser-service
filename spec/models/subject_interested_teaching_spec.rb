require 'rails_helper'

RSpec.describe SubjectInterestedTeaching, :vcr do
  let(:subject) { build(:subject_interested_teaching) }

  describe "#teaching_subject" do
    it "validates" do
      subject.teaching_subject = 'invalid-id'
      expect(subject).to_not be_valid
      subject.teaching_subject = '6b793433-cd1f-e911-a979-000d3a20838a'
      expect(subject).to be_valid
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(subject.next_step).to eq("start_teacher_training")
    end
  end
end