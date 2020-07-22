FactoryBot.define do
  factory :secondary_maths_english_grade4 do
    has_gcse_maths_and_english_id { SecondaryMathsEnglishGrade4::OPTIONS[:yes] }
  end
end
