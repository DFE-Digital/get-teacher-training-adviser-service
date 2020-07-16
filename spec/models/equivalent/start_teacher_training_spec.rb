require "rails_helper"

RSpec.describe Equivalent::StartTeacherTraining, :vcr do
  let(:starter) { build(:equivalent_start_teacher_training) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(starter.next_step).to eq("equivalent/date_of_birth")
    end
  end
end
