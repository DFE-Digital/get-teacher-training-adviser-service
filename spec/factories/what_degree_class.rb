FactoryBot.define do
  factory :what_degree_class do
    uk_degree_grade_id { WhatDegreeClass::OPTIONS["Not applicable"] }
  end
end
