require 'rails_helper'

RSpec.describe HasTeacherId do
  let(:has_id) { build(:has_teacher_id) }
  let(:wrong_answer) { build(:has_teacher_id, has_id: "invalid" ) }
  let(:no_id) { build(:has_teacher_id, has_id: false) }

  describe "validation" do
    it "only accepts true or false" do
      expect(wrong_answer).to be_valid
      expect(wrong_answer.has_id).to be_truthy
      expect(has_id).to be_valid
      expect(no_id).to be_valid
    end
  end

  describe "#next_step" do
    context "when answer is true" do
      it "returns the correct option" do
        expect(has_id.next_step).to eq("previous_id")
      end
    end

    context "when answer is false" do
      it "returns the correct option" do
        expect(no_id.next_step).to eq("previous_subject")
      end
    end

  end

end