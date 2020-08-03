class SubjectInterestedTeaching < Base
  attribute :preferred_teaching_subject_id, :string

  validates :preferred_teaching_subject_id, types: { method: :get_teaching_subjects }

  def next_step
    "start_teacher_training"
  end
end
