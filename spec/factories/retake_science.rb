FactoryBot.define do
  factory :retake_science do
    retaking_science { RetakeScience::OPTIONS[:yes] }
  end
end
