require "rails_helper"

RSpec.describe Degree::StartTeacherTraining do
  let(:starter) { build(:degree_start_teacher_training) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(starter.next_step).to eq("degree/date_of_birth")
    end
  end
end
