FactoryBot.define do
  factory :degree_what_subject_degree, :class => Degree::WhatSubjectDegree do
    degree_subject { "French" }
  end
end