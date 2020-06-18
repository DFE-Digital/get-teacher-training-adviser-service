FactoryBot.define do
  factory :primary_or_secondary do
    primary_or_secondary { PrimaryOrSecondary::STAGES[:primary] }
  end
end