require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::GcseScience do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :has_gcse_science_id }
  end

  describe "has_gcse_science_id" do
    it { is_expected.to_not allow_value(nil).for :has_gcse_science_id }
    it { is_expected.to allow_values(Crm::OPTIONS[:yes], Crm::OPTIONS[:no]).for :has_gcse_science_id }
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
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:primary]
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end

    it "returns true if preferred_education_phase_id is secondary" do
      wizardstore["preferred_education_phase_id"] = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree]
      expect(subject).to be_skipped
    end
  end
end
