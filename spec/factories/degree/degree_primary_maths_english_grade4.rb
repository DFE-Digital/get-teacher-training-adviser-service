FactoryBot.define do
  factory :degree_primary_maths_english_grade4, :class => Degree::PrimaryMathsEnglishGrade4 do
    has_required_subjects { "yes" }
  end
end