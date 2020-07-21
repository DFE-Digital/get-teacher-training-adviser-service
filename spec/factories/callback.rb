FactoryBot.define do
  factory :callback do
    telephone { "12345678" }
    callback_slot { ApiClient.get_callback_booking_quotas.first.start_at }
  end
end
