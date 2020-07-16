FactoryBot.define do
  factory :stage_of_degree, class: Studying::StageOfDegree do
    degree_stage { Studying::StageOfDegree::options["Final year"] }
  end
end
