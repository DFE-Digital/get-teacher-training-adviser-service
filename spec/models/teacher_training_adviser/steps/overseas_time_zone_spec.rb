require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::OverseasTimeZone do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { expect(described_class).to be TeacherTrainingAdviser::Steps::OverseasTimeZone }

  context "attributes" do
    it { is_expected.to respond_to :telephone }
  end

  describe "#skipped?" do
    it "returns false if degree_options is equivalent and uk_or_overseas is overseas" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not equivalent" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if uk_or_overseas is not overseas" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      wizardstore["returning_to_teaching"] = true
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before do
      instance.telephone = "1234567"
    end
    it {
      is_expected.to eq({
        "telephone" => "1234567",
      })
    }
  end
end
