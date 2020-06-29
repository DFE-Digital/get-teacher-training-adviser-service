class SubjectInterestedTeaching < Base
  attribute :teaching_subject, :string

  validates :teaching_subject, presence: true

  def next_step
    "start_teacher_training"
  end
end
