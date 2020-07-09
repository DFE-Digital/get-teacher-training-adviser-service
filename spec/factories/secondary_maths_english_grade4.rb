FactoryBot.define do
  factory :secondary_maths_english_grade4 do
    has_required_subjects { SecondaryMathsEnglishGrade4::OPTIONS[:yes] }
  end
end
