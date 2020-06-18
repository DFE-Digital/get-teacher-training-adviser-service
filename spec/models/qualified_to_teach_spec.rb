require 'rails_helper'

RSpec.describe QualifiedToTeach, :vcr do
  subject { build(:qualified_to_teach) }

  describe "#qualified_subject" do
    it "validates" do
      subject.qualified_subject = 'invalid-id'
      expect(subject).to_not be_valid
      subject.qualified_subject = '6b793433-cd1f-e911-a979-000d3a20838a'
      expect(subject).to be_valid
    end
  end

  describe "#next_step" do
    context "with valid input" do
      it "returns the correct step" do
        expect(subject.next_step).to eq("date_of_birth")
      end
    end
  end
end