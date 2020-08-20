require "rails_helper"

RSpec.describe Callback do
  subject { build(:callback) }
  let(:no_callback_slot) { build(:callback, phone_call_scheduled_at: "") }

  describe "validation" do
    context "with required attributes" do
      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "without required attributes" do
      it "is invalid" do
        expect(no_callback_slot).to_not be_valid
      end
    end

    context "with invalid phone_call_scheduled_at" do
      it "is invalid" do
        subject.phone_call_scheduled_at = "invalid_date"
        expect(subject).to_not be_valid
      end
    end

    context "with invalid phone number" do
      ["", "12345uh", "123-123-123"].each do |invalid_phone|
        it "is not valid" do
          expect(build(:equivalent_uk_callback, telephone: invalid_phone)).to_not be_valid
        end
      end
    end

    context "with valid phone numbers" do
      ["123456", "123456 90"].each do |valid_phone|
        it "is valid" do
          expect(build(:equivalent_uk_callback, telephone: valid_phone)).to be_valid
        end
      end
    end
  end

  describe "#self.grouped_quotas" do
    it "returns all quotas excluding today's date" do
      today = Time.now.to_datetime
      tomorrow = today + 1.day

      quotas = [
        GetIntoTeachingApiClient::CallbackBookingQuota.new(day: today.strftime, start_at: today, end_at: today + 1.hour),
        GetIntoTeachingApiClient::CallbackBookingQuota.new(day: tomorrow.strftime, start_at: tomorrow, end_at: tomorrow + 1.hour),
      ]
      allow(ApiClient).to receive(:get_callback_booking_quotas).and_return(quotas)

      grouped_quotas = described_class.grouped_quotas
      expect(grouped_quotas.keys.any? { |day| Date.parse(day) == Time.zone.today }).to be_falsy
      expect(grouped_quotas.keys.any? { |day| Date.parse(day) == Time.zone.tomorrow }).to be_truthy
    end
  end
end
