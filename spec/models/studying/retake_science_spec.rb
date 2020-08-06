require "rails_helper"

RSpec.describe Studying::RetakeScience, :vcr do
  let(:yes) { build(:studying_retake_science) }
  let(:no) { build(:studying_retake_science, planning_to_retake_gcse_science_id: RetakeScience::OPTIONS[:no]) }

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("studying/start_teacher_training")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("qualification_required")
      end
    end
  end
end
