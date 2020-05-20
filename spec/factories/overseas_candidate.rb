FactoryBot.define do
  factory :overseas_candidate do
    telephone_number { "12345678" }
    callback_date { "3 January 2021" }
    callback_time { "1100" }
  end
end