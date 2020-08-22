require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::QualificationRequired do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.to_not be_can_proceed }

  describe "#skipped?" do
    it "returns false if planning_to_retake_gcse_maths_and_english_id is no" do
      wizardstore["planning_to_retake_gcse_maths_and_english_id"] = Crm::OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns false if planning_to_retake_gcse_science_id is no" do
      wizardstore["planning_to_retake_gcse_science_id"] = Crm::OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns true if planning_to_retake_gcse_maths_and_english_id is not no" do
      wizardstore["planning_to_retake_gcse_maths_and_english_id"] = Crm::OPTIONS[:yes]
      expect(subject).to be_skipped
      wizardstore["planning_to_retake_gcse_maths_and_english_id"] = nil
      expect(subject).to be_skipped
    end
  end
end
