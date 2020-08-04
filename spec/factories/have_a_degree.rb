FactoryBot.define do
  factory :have_a_degree do
    degree_options { HaveADegree::DEGREE_OPTIONS[:yes] }
  end
end
