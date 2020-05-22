class SubjectInterestedTeaching < Base
  attribute :teaching_subject, :string
  
  validates :teaching_subject, inclusion: { in: %w(Maths History English French), message: "Please select an option."}

  def next_step
    "start_teacher_training"
  end
end