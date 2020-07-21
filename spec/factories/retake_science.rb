FactoryBot.define do
  factory :retake_science do
    planning_to_retake_cgse_science_id { RetakeScience::OPTIONS[:yes] }
  end
end
