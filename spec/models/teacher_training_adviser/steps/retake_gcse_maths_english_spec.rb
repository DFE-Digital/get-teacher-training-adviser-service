require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :planning_to_retake_gcse_maths_and_english_id }
  end

  describe "planning_to_retake_gcse_maths_and_english_id" do
    it { is_expected.to_not allow_value(nil).for :planning_to_retake_gcse_maths_and_english_id }
    it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS.values).for :planning_to_retake_gcse_maths_and_english_id }
  end

  describe "#skipped?" do
    it "returns false if has_gcse_maths_and_english_id is no" do
      wizardstore["has_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end

    it "returns true if degree_options is equivalent" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end

    it "returns true if has_gcse_maths_and_english_id is not not no" do
      wizardstore["has_gcse_maths_and_english_id"] = nil
      expect(subject).to be_skipped
      wizardstore["has_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:yes]
      expect(subject).to be_skipped
    end
  end
end
