require "rails_helper"

RSpec.describe CallbackHelper, type: :helper do
  let(:date) { Time.gm(2020, 8, 19, 9, 30).to_datetime }
  let(:date_string) { date.strftime }
  let(:grouped_quotas) do
    {
      date_string.to_s => [
        GetIntoTeachingApiClient::CallbackBookingQuota.new(
          startAt: date,
          endAt: date + 30.minutes,
        ),
      ],
    }
  end

  describe "#format_booking_quotas" do
    it "formats in GTM by default" do
      formatted_quotas = format_booking_quotas(grouped_quotas)
      time_slots = formatted_quotas[date_string]
      first_slot = time_slots.first
      expect(first_slot).to eq(
        ["09:30 am - 10:00 am", grouped_quotas[date_string].first.start_at],
      )
    end

    it "formats by the given time zone" do
      formatted_quotas = format_booking_quotas(grouped_quotas, "London")
      time_slots = formatted_quotas[date_string]
      first_slot = time_slots.first
      expect(first_slot).to eq(
        ["10:30 am - 11:00 am", grouped_quotas[date_string].first.start_at],
      )
    end
  end
end
