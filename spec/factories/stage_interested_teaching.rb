FactoryBot.define do
  factory :stage_interested_teaching do
    primary_or_secondary { StageInterestedTeaching::STAGES[:primary] }

    trait :secondary do
      primary_or_secondary { StageInterestedTeaching::STAGES[:secondary] }
    end
  end
end