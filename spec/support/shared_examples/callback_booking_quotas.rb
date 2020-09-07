RSpec.shared_examples "exposes callback booking quotas" do
  before do
    allow_any_instance_of(GetIntoTeachingApiClient::CallbackBookingQuotasApi).to \
      receive(:get_callback_booking_quotas) { quotas }
  end

  let(:quotas) do
    [
      GetIntoTeachingApiClient::CallbackBookingQuota.new(startAt: 1.day.from_now, endAt: 1.day.from_now + 30.minutes),
      GetIntoTeachingApiClient::CallbackBookingQuota.new(startAt: 2.days.from_now, endAt: 2.days.from_now + 30.minutes),
    ]
  end

  subject { described_class.callback_booking_quotas }

  it { is_expected.to eq(quotas) }
end
