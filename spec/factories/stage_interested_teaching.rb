FactoryBot.define do
  factory :stage_interested_teaching do
    preferred_education_phase_id { StageInterestedTeaching::OPTIONS[:primary] }
  end
end
