require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::NoDegree do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { is_expected.to_not be_can_proceed }

  describe "#skipped?" do
    it "returns false if degree_options is no" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:no]
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not no" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      expect(subject).to be_skipped
    end
  end
end
