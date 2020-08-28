require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::QualificationRequired do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.to_not be_can_proceed }

  describe "#skipped?" do
    it "returns false if has gcse maths/english, primary, doesn't have or retaking gcse science" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:primary]
      wizardstore["has_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:yes]
      wizardstore["has_gcse_science_id"] = TeacherTrainingAdviser::Steps::GcseScience::OPTIONS[:no]
      wizardstore["planning_to_retake_gcse_science_id"] = TeacherTrainingAdviser::Steps::RetakeGcseScience::OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns false if does not have or planning to retake gcse maths/english, secondary" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      wizardstore["has_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:no]
      wizardstore["planning_to_retake_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is equivalent is true" do
      wizardstore["degree_options"] = "equivalent"
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end

    it "returns true if preferred_education_phase_id is primary and has gcse maths/english" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      wizardstore["has_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:yes]
      expect(subject).to be_skipped
    end

    it "returns true if preferred_education_phase_id is primary and retaking gcse maths/english" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      wizardstore["planning_to_retake_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:yes]
      expect(subject).to be_skipped
    end

    it "returns true if preferred_education_phase_id is secondary and has gcse science" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      wizardstore["has_gcse_science_id"] = TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:yes]
      expect(subject).to be_skipped
    end

    it "returns true if preferred_education_phase_id is secondary and retaking gcse science" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      wizardstore["planning_to_retake_gcse_science_id"] = TeacherTrainingAdviser::Steps::RetakeGcseScience::OPTIONS[:yes]
      expect(subject).to be_skipped
    end
  end
end
