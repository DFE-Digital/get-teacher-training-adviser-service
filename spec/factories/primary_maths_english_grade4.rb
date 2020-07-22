FactoryBot.define do
  factory :primary_maths_english_grade4 do
    has_gcse_maths_and_english_id { PrimaryMathsEnglishGrade4::OPTIONS[:yes] }
  end
end
