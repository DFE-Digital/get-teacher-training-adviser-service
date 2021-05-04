require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::OverseasCallback do
  it_behaves_like "exposes callback booking quotas"
  include_context "wizard step"
  it_behaves_like "a wizard step"

  it { expect(described_class).to be TeacherTrainingAdviser::Steps::OverseasCallback }

  context "attributes" do
    it { is_expected.to respond_to :phone_call_scheduled_at }
  end

  describe "#skipped?" do
    it "returns false if OverseasCountry/HaveADegree steps were shown and degree_options is equivalent" do
      allow(Rails).to receive(:env) { "preprod".inquiry }
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?) { false }
      expect_any_instance_of(TeacherTrainingAdviser::Steps::OverseasCountry).to receive(:skipped?) { false }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to_not be_skipped
    end

    it "returns true if OverseasCountry was skipped" do
      allow(Rails).to receive(:env) { "preprod".inquiry }
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?) { false }
      expect_any_instance_of(TeacherTrainingAdviser::Steps::OverseasCountry).to receive(:skipped?) { true }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end

    it "returns true if degree_options is not equivalent" do
      allow(Rails).to receive(:env) { "preprod".inquiry }
      expect_any_instance_of(TeacherTrainingAdviser::Steps::OverseasCountry).to receive(:skipped?) { false }
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?) { false }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      expect(subject).to be_skipped
    end

    it "returns true in production" do
      allow(Rails).to receive(:env) { "production".inquiry }
      expect_any_instance_of(TeacherTrainingAdviser::Steps::OverseasCountry).to receive(:skipped?) { false }
      expect_any_instance_of(TeacherTrainingAdviser::Steps::HaveADegree).to receive(:skipped?) { false }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    let(:date_time) { DateTime.new(2022, 1, 1, 10, 30) }
    subject { instance.reviewable_answers }
    before do
      instance.phone_call_scheduled_at = date_time
    end
    it {
      is_expected.to eq({
        "callback_date" => date_time.to_date,
        "callback_time" => date_time.to_time, # rubocop:disable Rails/Date
      })
    }

    context "when the phone_call_scheduled_at is nil" do
      let(:date_time) { nil }

      it { is_expected.to eq({ "callback_date" => nil, "callback_time" => nil }) }
    end
  end
end
