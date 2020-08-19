class ReturningTeacher < Base
  DEGREE_OPTIONS = { returner: "returner" }.freeze

  attribute :returning_to_teaching, :boolean
  attribute :degree_options, :string, default: -> { DEGREE_OPTIONS[:returner] }
  attribute :preferred_education_phase_id, :integer, default: -> { StageInterestedTeaching::OPTIONS[:secondary].to_i }

  validates :returning_to_teaching, inclusion: { in: [true, false], message: "You must select either yes or no" }

  def next_step
    if returning_to_teaching == true
      "has_teacher_id"
    else
      "have_a_degree"
    end
  end
end
