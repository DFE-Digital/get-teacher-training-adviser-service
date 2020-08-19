class ReturningTeacher < Base
  attribute :returning_to_teaching, :boolean
  attribute :degree_options, :string
  attribute :preferred_education_phase_id, :integer

  DEGREE_OPTIONS = { returner: "returner" }.freeze

  before_validation :set_degree_options
  before_validation :set_education_phase

  validates :returning_to_teaching, inclusion: { in: [true, false], message: "You must select either yes or no" }

  def set_degree_options
    self.degree_options = DEGREE_OPTIONS[:returner]
  end

  def set_education_phase
    self.preferred_education_phase_id = StageInterestedTeaching::OPTIONS[:secondary].to_i
  end

  def next_step
    if returning_to_teaching == true
      "has_teacher_id"
    else
      "have_a_degree"
    end
  end
end