FactoryBot.define do
  factory :primary_maths_english_grade4 do
    has_required_subjects { PrimaryMathsEnglishGrade4::OPTIONS[:yes] }
  end
end
