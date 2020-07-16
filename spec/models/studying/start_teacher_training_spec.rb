require "rails_helper"

RSpec.describe Studying::StartTeacherTraining, :vcr do
  let(:starter) { build(:studying_start_teacher_training) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(starter.next_step).to eq("studying/date_of_birth")
    end
  end
end
