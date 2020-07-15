FactoryBot.define do
  factory :overseas_country do
    country_code { OverseasCountry::options["Togo"] }
  end
end
