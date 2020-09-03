require "rails_helper"

RSpec.describe CallbackHelper, type: :helper do
  before { Timecop.freeze(Time.utc(2020, 4, 6, 10, 30)) }
  after { Timecop.return }

  let(:today) { DateTime.now }
  let(:tomorrow) { Time.utc(2020, 4, 7, 10) }
  let(:quotas) do
    [
      GetIntoTeachingApiClient::CallbackBookingQuota.new(startAt: today, endAt: today + 30.minutes),
      GetIntoTeachingApiClient::CallbackBookingQuota.new(startAt: tomorrow, endAt: tomorrow + 30.minutes),
    ]
  end

  describe "#format_booking_quotas" do
    let(:time_zone) { nil }

    subject { format_booking_quotas(quotas, time_zone) }

    it { expect(subject.keys).to_not include("Monday 6 April") }
    it { is_expected.to eq({ "Tuesday 7 April" => [["10:00 am - 10:30 am", tomorrow]] }) }

    context "when given a time zone of GMT+2" do
      let(:time_zone) { "Europe/Madrid" }

      it { is_expected.to eq({ "Tuesday 7 April" => [["12:00 pm - 12:30 pm", tomorrow]] }) }
    end

    context "when given a time zone of GMT-11 (resulting in 'today' being the 5th)" do
      let(:time_zone) { "American Samoa" }

      it { is_expected.to eq({ "Monday 6 April" => [["11:00 pm - 11:30 pm", tomorrow]] }) }
    end
  end
end
