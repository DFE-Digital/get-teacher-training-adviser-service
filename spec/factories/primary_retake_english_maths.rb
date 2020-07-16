FactoryBot.define do
  factory :primary_retake_english_maths do
    retaking_english_maths { PrimaryRetakeEnglishMaths::OPTIONS[:yes] }
  end
end
