FactoryBot.define do
  factory :callback do
    telephone { "12345678" }
    phone_call_scheduled_at { ApiClient.get_callback_booking_quotas.last.start_at }
  end
end
