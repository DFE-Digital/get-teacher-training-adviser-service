require 'rails_helper'

RSpec.describe ReturningTeacher do
  let(:returning_teacher) { build(:returning_teacher) }
  let(:wrong_answer) { build(:returning_teacher, returning_to_teaching: "dont know") }
  let(:new_teacher) { build(:returning_teacher, returning_to_teaching: "no") }

  describe "validation" do
    it "only accepts yes or no" do
      expect(wrong_answer).not_to be_valid
      expect(returning_teacher).to be_valid
      expect(new_teacher).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(returning_teacher.next_step).to eq("has_teacher_id")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(new_teacher.next_step).to eq("have_a_degree")
      end
    end
  end
end
