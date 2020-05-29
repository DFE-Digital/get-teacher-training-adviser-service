FactoryBot.define do
  factory :degree_subject_interested_teaching, :class => Degree::SubjectInterestedTeaching do
    teaching_subject { "Maths" }
  end
end