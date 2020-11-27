module TeacherTrainingAdviser::Steps
  class ReturningTeacher < Wizard::Step
    DEGREE_OPTIONS = { returner: "returner" }.freeze

    attribute :returning_to_teaching, :boolean
    attribute :degree_options, :string
    attribute :preferred_education_phase_id

    validates :returning_to_teaching, inclusion: { in: [true, false] }

    def returning_to_teaching=(value)
      super
      return unless returning_to_teaching

      self.degree_options = DEGREE_OPTIONS[:returner]
    end

    def reviewable_answers
      {
        "returning_to_teaching" => returning_to_teaching ? "Yes" : "No",
      }
    end
  end
end
