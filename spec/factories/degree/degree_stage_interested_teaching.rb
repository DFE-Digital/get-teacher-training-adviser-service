FactoryBot.define do
  factory :degree_stage_interested_teaching, :class => Degree::StageInterestedTeaching do
    primary_or_secondary { "primary" }
  end
end