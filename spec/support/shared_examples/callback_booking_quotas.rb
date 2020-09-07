RSpec.shared_examples "exposes callback booking quotas" do
  before do
    allow_any_instance_of(GetIntoTeachingApiClient::CallbackBookingQuotasApi).to \
      receive(:get_callback_booking_quotas) { quotas }
  end

  let(:utc_today) { DateTime.now.utc }
  let(:utc_tomorrow) { Time.utc(2020, 4, 7, 10) }
  let(:quota_today) do
    GetIntoTeachingApiClient::CallbackBookingQuota.new(
      startAt: utc_today,
      endAt: utc_today + 30.minutes,
    )
  end
  let(:quota_tomorrow) do
    GetIntoTeachingApiClient::CallbackBookingQuota.new(
      startAt: utc_tomorrow,
      endAt: utc_tomorrow + 30.minutes,
    )
  end
  let(:quotas) { [quota_today, quota_tomorrow] }

  describe "#callback_booking_quotas" do
    let(:time_zone) { "UTC" }

    subject { described_class.callback_booking_quotas }

    around do |example|
      Time.use_zone(time_zone) { example.run }
    end

    it { is_expected.to eq([quota_tomorrow]) }
  end
end
