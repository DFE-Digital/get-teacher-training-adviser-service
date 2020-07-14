FactoryBot.define do
  factory :overseas_candidate do
    telephone_number { "12345678" }
    callback_slot { ApiClient::get_callback_booking_quotas.first.id }
    time_zone { "Hawaii" }
  end
end
