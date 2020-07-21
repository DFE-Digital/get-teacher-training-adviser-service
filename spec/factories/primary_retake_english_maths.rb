FactoryBot.define do
  factory :primary_retake_english_maths do
    planning_to_retake_gcse_maths_and_english_id { PrimaryRetakeEnglishMaths::OPTIONS[:yes] }
  end
end
