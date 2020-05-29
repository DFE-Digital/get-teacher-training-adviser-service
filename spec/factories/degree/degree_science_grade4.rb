FactoryBot.define do
  factory :degree_science_grade4, :class => Degree::ScienceGrade4 do
    have_science { "yes" }
  end
end