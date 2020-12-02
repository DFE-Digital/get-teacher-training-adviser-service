require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :planning_to_retake_gcse_maths_and_english_id }
  end

  describe "planning_to_retake_gcse_maths_and_english_id" do
    it { is_expected.to_not allow_values(nil, 123).for :planning_to_retake_gcse_maths_and_english_id }
    it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS.values).for :planning_to_retake_gcse_maths_and_english_id }
  end

  describe "#skipped?" do
    it "returns false if GcseMathsEnglish step was shown and has_gcse_maths_and_english_id is no" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::GcseMathsEnglish).to receive(:skipped?) { false }
      wizardstore["has_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns true if GcseMathsEnglish was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::GcseMathsEnglish).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end

    it "returns true if has_gcse_maths_and_english_id is not no" do
      wizardstore["has_gcse_maths_and_english_id"] = nil
      expect(subject).to be_skipped
      wizardstore["has_gcse_maths_and_english_id"] = TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:yes]
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before { instance.planning_to_retake_gcse_maths_and_english_id = Crm::OPTIONS[:yes] }
    it { is_expected.to eq({ "planning_to_retake_gcse_maths_and_english_id" => "Yes" }) }
  end
end
