FactoryBot.define do
  factory :science_grade4 do
    have_science { ScienceGrade4::OPTIONS[:yes] }
  end
end
