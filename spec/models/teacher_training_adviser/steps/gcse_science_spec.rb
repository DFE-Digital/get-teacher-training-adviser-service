require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::GcseScience do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :has_gcse_science_id }
  end

  describe "has_gcse_science_id" do
    it { is_expected.to_not allow_values(nil, 123).for :has_gcse_science_id }
    it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::GcseScience::OPTIONS.values).for :has_gcse_science_id }
  end

  describe "#skipped?" do
    it "returns false if degree_options is studying/degree and preferred_education_phase_id primary" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:primary]
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
      expect(subject).to_not be_skipped
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree]
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not studying/degree" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end

    it "returns true if preferred_education_phase_id is secondary" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end

    it "returns true if has_gcse_maths_and_english_id and planning_to_retake_gcse_maths_and_english_id are no" do
      wizardstore["has_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:no]
      wizardstore["planning_to_retake_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:no]
      expect(subject).to be_skipped
    end
  end
end
