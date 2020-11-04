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
    it "returns false if degree_options is equivalent and uk_or_overseas is UK" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not equivalent" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:yes]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:uk]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if uk_or_overseas is not UK" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      wizardstore["returning_to_teaching"] = false
      expect(subject).to be_skipped
    end

    it "returns true if returning_to_teaching is true" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      wizardstore["uk_or_overseas"] = TeacherTrainingAdviser::Steps::UkOrOverseas::OPTIONS[:overseas]
      wizardstore["returning_to_teaching"] = true
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
