require 'rails_helper'

RSpec.describe Degree::RetakeScience do
  let(:retake_science) { build(:degree_retake_science) }
  let(:no) { build(:degree_retake_science, retaking_science: false) }

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(retake_science.next_step).to eq("degree/start_teacher_training")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("qualification_required")
      end
    end
  end
end
