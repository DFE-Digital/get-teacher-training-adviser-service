FactoryBot.define do
  factory :subject_like_to_teach do
    preferred_teaching_subject_id { SubjectLikeToTeach.options["Maths"] }
  end
end
