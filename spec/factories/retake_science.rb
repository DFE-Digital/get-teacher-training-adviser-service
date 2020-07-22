FactoryBot.define do
  factory :retake_science do
    planning_to_retake_gcse_science_id { RetakeScience::OPTIONS[:yes] }
  end
end
