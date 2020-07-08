require "rails_helper"

RSpec.describe Degree::ScienceGrade4, :vcr do
  let(:yes) { build(:degree_science_grade4) }
  let(:no) { build(:degree_science_grade4, have_science: ScienceGrade4::OPTIONS[:no]) }

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("degree/start_teacher_training")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("degree/retake_science")
      end
    end
  end
end
