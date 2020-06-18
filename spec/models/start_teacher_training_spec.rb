require 'rails_helper'

RSpec.describe StartTeacherTraining, :vcr do
  subject { build(:start_teacher_training) }

  describe "#year_of_entry" do
    it "validates" do
      subject.year_of_entry = 'invalid-id'
      expect(subject).to_not be_valid
      subject.year_of_entry = '22302'
      expect(subject).to be_valid
    end
  end

  describe "#next_step" do
    it "returns the correct option" do
      expect(subject.next_step).to eq("date_of_birth")
    end
  end
end