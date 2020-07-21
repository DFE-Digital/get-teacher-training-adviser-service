FactoryBot.define do
  factory :overseas_country do
    country_id { OverseasCountry::options["Togo"] }
  end
end
