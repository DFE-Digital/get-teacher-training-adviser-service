require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::UkCallback do
  it_behaves_like "exposes callback booking quotas"
  include_context "wizard step"
  it_behaves_like "a wizard step"
  include_context "sanitize fields", %i[telephone]

  context "attributes" do
    it { is_expected.to respond_to :phone_call_scheduled_at }
    it { is_expected.to respond_to :telephone }
  end

  context "phone_call_scheduled_at" do
    it { is_expected.to_not allow_values("", nil, "invalid_date").for :phone_call_scheduled_at }
    it { is_expected.to allow_value(Time.zone.now).for :phone_call_scheduled_at }
  end

  context "telephone" do
    it { is_expected.to_not allow_values(nil, "", "abc12345", "12", "1" * 21).for :telephone }
    it { is_expected.to allow_values("123456789").for :telephone }
  end

  describe "#skipped?" do
    it "returns false if UkAddress step was shown and degree_options is equivalent" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::UkAddress).to receive(:skipped?) { false }
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to_not be_skipped
    end

    it "returns true if UkAddress was skipped" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::UkAddress).to receive(:skipped?) { true }
      expect(subject).to be_skipped
    end

    it "returns true if degree_options is not equivalent" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    let(:date_time) { DateTime.new(2022, 1, 1, 10, 30) }
    subject { instance.reviewable_answers }
    before { instance.phone_call_scheduled_at = date_time }
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
