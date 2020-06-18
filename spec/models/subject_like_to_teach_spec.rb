require 'rails_helper'

RSpec.describe SubjectLikeToTeach, :vcr do
  let(:subject) { build(:subject_like_to_teach) }

  describe "#like_to_teach" do
    it "validates" do
      subject.like_to_teach = 'invalid-id'
      expect(subject).to_not be_valid
      subject.like_to_teach = '6b793433-cd1f-e911-a979-000d3a20838a'
      expect(subject).to be_valid
    end
  end

  describe "#next_step" do
    it "returns the correct step" do
      expect(subject.next_step).to eq("date_of_birth")
    end
  end
end