module TeacherTrainingAdviser::Steps
  class ReturningTeacher < Wizard::Step
    DEGREE_OPTIONS = { returner: "returner" }.freeze

    attribute :returning_to_teaching, :boolean
    attribute :degree_options, :string
    attribute :preferred_education_phase_id

    validates :returning_to_teaching, inclusion: { in: [true, false], message: "You must select either yes or no" }

    def returning_to_teaching=(value)
      super
      return unless returning_to_teaching

      self.degree_options = DEGREE_OPTIONS[:returner]
      self.preferred_education_phase_id = TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary].to_i
    end
  end
end
