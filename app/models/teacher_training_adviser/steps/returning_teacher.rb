module TeacherTrainingAdviser::Steps
  class ReturningTeacher < Wizard::Step
    DEGREE_OPTIONS = { returner: "returner" }.freeze

    attribute :returning_to_teaching, :boolean
    attribute :degree_options, :string, default: -> { DEGREE_OPTIONS[:returner] }
    attribute :preferred_education_phase_id, :integer, default: -> { StageInterestedTeaching::OPTIONS[:secondary].to_i }

    validates :returning_to_teaching, inclusion: { in: [true, false], message: "You must select either yes or no" }
  end
end
