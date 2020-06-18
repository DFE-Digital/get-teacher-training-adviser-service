class StartTeacherTraining < Base
  attribute :year_of_entry, :string

  validates :year_of_entry, types: { method: :get_candidate_initial_teacher_training_years }

  def next_step
    "date_of_birth"
  end
end 