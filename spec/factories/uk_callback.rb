FactoryBot.define do
  factory :uk_callback do
    telephone_number { "12345678" }
    callback_date { Date.tomorrow }
    callback_time { "1100" }
  end
end
