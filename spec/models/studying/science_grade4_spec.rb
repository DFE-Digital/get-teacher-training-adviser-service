require "rails_helper"

RSpec.describe Studying::ScienceGrade4, :vcr do
  let(:yes) { build(:studying_science_grade4) }
  let(:no) { build(:studying_science_grade4, have_science: ScienceGrade4::OPTIONS[:no]) }

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("studying/start_teacher_training")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("studying/retake_science")
      end
    end
  end
end
