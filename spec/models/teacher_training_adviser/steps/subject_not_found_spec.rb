require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::SubjectNotFound do
  include_context "with a wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.not_to be_can_proceed }

  describe "#skipped?" do
    it "returns false if returning_to_teaching is true and preferred_teaching_subject_id is -1" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to receive(:returning_to_teaching).and_return(true)
      wizardstore["preferred_teaching_subject_id"] = -1
      expect(subject).not_to be_skipped
    end

    it "returns true if returning_teacher is false" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to receive(:returning_to_teaching).and_return(false)
      wizardstore["preferred_teaching_subject_id"] = -1
      expect(subject).to be_skipped
    end

    it "returns true if preferred_teaching_subject_id is not -1" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to receive(:returning_to_teaching).and_return(true)
      wizardstore["preferred_teaching_subject_id"] = "abc-123"
      expect(subject).to be_skipped
    end
  end
end
