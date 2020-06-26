require "rails_helper"

RSpec.describe Studying::SubjectInterestedTeaching do
  let(:what_subject) { build(:studying_subject_interested_teaching) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_subject.next_step).to eq("studying/start_teacher_training")
    end
  end
end
