FactoryBot.define do
  factory :science_grade4 do
    has_gcse_science_id { ScienceGrade4::OPTIONS[:yes] }
  end
end
