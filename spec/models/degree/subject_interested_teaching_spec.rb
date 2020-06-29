require "rails_helper"

RSpec.describe Degree::SubjectInterestedTeaching do
  let(:what_subject) { build(:degree_subject_interested_teaching) }

  describe "#next_step" do
    it "returns the correct option" do
      expect(what_subject.next_step).to eq("degree/start_teacher_training")
    end
  end
end
