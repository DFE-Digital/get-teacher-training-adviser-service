require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::UkCallback do
  include_context "wizard step"
  it_behaves_like "a wizard step"

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
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree]
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

  describe "#self.grouped_quotas" do
    it "returns all quotas excluding today's date" do
      today = DateTime.now
      tomorrow = DateTime.now + 1.day

      quotas = [
        GetIntoTeachingApiClient::CallbackBookingQuota.new(day: today.strftime, start_at: today, end_at: today + 1.hour),
        GetIntoTeachingApiClient::CallbackBookingQuota.new(day: tomorrow.strftime, start_at: tomorrow, end_at: tomorrow + 1.hour),
      ]
      allow_any_instance_of(GetIntoTeachingApiClient::CallbackBookingQuotasApi).to \
        receive(:get_callback_booking_quotas).and_return(quotas)

      grouped_quotas = described_class.grouped_quotas
      expect(grouped_quotas.keys.any? { |day| Date.parse(day) == Time.zone.today }).to be_falsy
      expect(grouped_quotas.keys.any? { |day| Date.parse(day) == Time.zone.tomorrow }).to be_truthy
    end
  end
end
