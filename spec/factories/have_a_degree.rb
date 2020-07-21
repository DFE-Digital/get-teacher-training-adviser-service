FactoryBot.define do
  factory :have_a_degree do
    degree_status_id { HaveADegree::OPTIONS[:yes] }
  end
end
