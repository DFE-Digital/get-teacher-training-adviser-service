module TeacherTrainingAdviser::Steps
  class ReturningTeacher < Wizard::Step
    OPTIONS = { returning_to_teaching: 222_750_001, interested_in_teaching: 222_750_000 }.freeze
    DEGREE_OPTIONS = { returner: "returner" }.freeze

    attribute :type_id, :integer
    attribute :degree_options, :string

    validates :type_id, pick_list_items: { method: :get_candidate_types }

    def type_id=(value)
      super
      return unless value == OPTIONS[:returning_to_teaching]

      self.degree_options = DEGREE_OPTIONS[:returner]
    end

    def returning_to_teaching
      type_id == OPTIONS[:returning_to_teaching]
    end

    def reviewable_answers
      {
        "returning_to_teaching" => returning_to_teaching ? "Yes" : "No",
      }
    end
  end
end
