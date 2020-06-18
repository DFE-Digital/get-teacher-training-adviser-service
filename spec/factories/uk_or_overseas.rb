FactoryBot.define do
  factory :uk_or_overseas do
    uk_or_overseas { UkOrOverseas::LOCATIONS[:uk] }

    trait :overseas do
      uk_or_overseas { UkOrOverseas::LOCATIONS[:overseas] }
    end
  end
end