class SubjectLikeToTeach < Base
  attribute :like_to_teach, :string

  validates :like_to_teach, types: { method: :get_teaching_subjects, 
    message: "Please select maths, physics or modern foreign language" }

  def next_step
    "date_of_birth"
  end
end