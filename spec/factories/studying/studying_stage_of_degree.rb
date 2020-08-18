FactoryBot.define do
  factory :stage_of_degree, class: Studying::StageOfDegree do
    degree_status_id { Studying::StageOfDegree.options["Final year"] }
  end
end
