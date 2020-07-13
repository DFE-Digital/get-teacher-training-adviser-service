FactoryBot.define do
  factory :uk_callback do
    telephone_number { "12345678" }
    callback_slot { ApiClient.get_callback_booking_quotas.first.id }
  end
end
