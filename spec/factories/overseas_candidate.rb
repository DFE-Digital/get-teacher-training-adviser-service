FactoryBot.define do
  factory :overseas_candidate do
    telephone_number { "12345678" }
    callback_date { Date.tomorrow }
    callback_time { "1100" }
    time_zone { "Hawaii" }
  end
end
