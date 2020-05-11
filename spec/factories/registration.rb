FactoryBot.define do
  factory :registration do
    email_address { "me@example.com"}
    first_name { "John" }
    last_name { " Don "}
    returning_to_teaching { true }
    stage { 0 }

    trait :stage0 do
      stage { 0 }
    end

    trait :stage1  do
      stage { 1 }
    end

    trait :returning_to_teaching do
      returning_to_teaching { true }
    end

    trait :not_returning_to_teaching do
      returning_to_teaching { false }
    end
  end
end