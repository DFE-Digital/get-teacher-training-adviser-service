FactoryBot.define do
  factory :identity do
    email_address { "me@example.com"}
    first_name { "John" }
    last_name { " Don "}
  end
end