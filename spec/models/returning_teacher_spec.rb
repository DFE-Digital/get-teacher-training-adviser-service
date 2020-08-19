require "rails_helper"

RSpec.describe ReturningTeacher do
  let(:returning_teacher) { build(:returning_teacher) }
  let(:wrong_answer) { build(:returning_teacher, returning_to_teaching: "dont know") }
  let(:new_teacher) { build(:returning_teacher, returning_to_teaching: false) }

  describe "validation" do
    it "only accepts true or false values" do
      expect(wrong_answer).to be_valid
      expect(returning_teacher).to be_valid
      expect(new_teacher).to be_valid
    end
  end

  describe "#set_degree_options" do
    it "sets the degree option before validation" do
      returning_teacher.valid?
      expect(returning_teacher.degree_options).to eq(ReturningTeacher::DEGREE_OPTIONS[:returner])
    end
  end

  describe "#set_education_phase" do
    it "sets the preferred_education_phase_id before validation" do
      returning_teacher.valid?
      expect(returning_teacher.preferred_education_phase_id).to eq(StageInterestedTeaching::OPTIONS[:secondary].to_i)
    end
  end

  describe "#next_step" do
    context "when answer is true" do
      it "returns the correct option" do
        expect(returning_teacher.next_step).to eq("has_teacher_id")
      end
    end

    context "when answer is false" do
      it "returns the correct option" do
        expect(new_teacher.next_step).to eq("have_a_degree")
      end
    end
  end
end