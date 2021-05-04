require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::OverseasTimeZone do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { expect(described_class).to be TeacherTrainingAdviser::Steps::OverseasTimeZone }

  it { expect(described_class).to be_contains_personal_details }

  context "attributes" do
    it { is_expected.to respond_to :time_zone }
    it { is_expected.to respond_to :telephone }
  end

  describe "telephone" do
    it { is_expected.to_not allow_values(nil, "abc12345", "12", "1" * 21).for :telephone }
    it { is_expected.to allow_values("123456789").for :telephone }
  end

  context "time_zone" do
    it { is_expected.to_not allow_values("", nil).for :time_zone }
    it { is_expected.to allow_values(ActiveSupport::TimeZone.all).for :time_zone }

    context "when in production" do
      before { allow(Rails).to receive(:env) { "production".inquiry } }

      it { is_expected.not_to validate_presence_of :time_zone }
    end
  end

  describe "#filtered_time_zones" do
    subject { instance.filtered_time_zones }

    it "removes 'International Date Line West' value from ActiveSupport::TimeZones" do
      expect(subject.map(&:name)).not_to include("International Date Line West")
    end
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
      instance.time_zone = "London"
    end
    it {
      is_expected.to eq({
        "time_zone" => "London",
        "telephone" => "1234567",
      })
    }

    context "when time_zone is nil" do
      before { instance.time_zone = nil }

      it { is_expected.to eq({ "telephone" => "1234567" }) }
    end
  end
end
