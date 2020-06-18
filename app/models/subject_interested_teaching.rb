class SubjectInterestedTeaching < Base
  attribute :teaching_subject, :string
  
  validates :teaching_subject, types: { method: :get_teaching_subjects }

  def next_step
    "start_teacher_training"
  end
end