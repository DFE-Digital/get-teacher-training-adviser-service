class ReturningTeacher < Base
  attribute :returning_to_teaching, :boolean
  attribute :degree_options, :string

  before_validation :set_degree_options

  validates :returning_to_teaching, inclusion: { in: [true, false], message: "You must select either yes or no" }

  def set_degree_options
    self.degree_options = "returner"
  end

  def next_step
    if returning_to_teaching == true
      "has_teacher_id"
    else
      "have_a_degree"
    end
  end
end
