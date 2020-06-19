require 'rails_helper'

RSpec.describe Degree::ScienceGrade4 do
  let(:science_grade4) { build(:degree_science_grade4) }
  let(:new_teacher) { build(:degree_science_grade4, have_science: "no") }

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(science_grade4.next_step).to eq("degree/start_teacher_training")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(new_teacher.next_step).to eq("degree/retake_science")
      end
    end
  end
end
