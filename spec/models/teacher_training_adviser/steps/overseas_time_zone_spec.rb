require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::OverseasTimeZone do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { expect(described_class).to be TeacherTrainingAdviser::Steps::OverseasTimeZone }

  it { expect(described_class).to be_contains_personal_details }

  context "attributes" do
    it { is_expected.to respond_to :telephone }
  end

  describe "#skipped?" do
    it "returns false if OverseasCountry was shown and they have an equivalent degree" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::OverseasCountry).to receive(:skipped?) { false }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to_not be_skipped
    end

    it "returns true if OverseasCountry was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::OverseasCountry).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end

    it "returns true if degree_options is not equivalent" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
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
