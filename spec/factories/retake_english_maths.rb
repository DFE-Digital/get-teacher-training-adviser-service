FactoryBot.define do
  factory :retake_english_maths do
    planning_to_retake_gcse_maths_and_english_id { RetakeEnglishMaths::OPTIONS[:yes] }
  end
end
