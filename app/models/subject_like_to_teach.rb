class SubjectLikeToTeach < Base
  attribute :like_to_teach, :string

  validates :like_to_teach, inclusion: { in: [
    "maths", "physics", "modern foreign language"
    ],
    message: "Please select maths, physics or modern foreign language" }

  def next_step
    "date_of_birth"
  end
end
