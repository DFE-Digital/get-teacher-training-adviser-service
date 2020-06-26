require "rails_helper"

RSpec.describe Equivalent::SubjectInterestedTeaching do
  let(:what_subject) { build(:equivalent_subject_interested_teaching) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_subject.next_step).to eq("equivalent/start_teacher_training")
    end
  end
end
