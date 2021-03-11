require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::NoDegree do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.to_not be_can_proceed }

  describe "#skipped?" do
    it "returns false if degree_options is no and HaveADegree step was shown" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?) { false }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not no and HaveADegree step was shown" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?) { false }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      expect(subject).to be_skipped
    end

    it "returns true if HaveADegree step is skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?) { true }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:no]
      expect(subject).to be_skipped
    end
  end
end
