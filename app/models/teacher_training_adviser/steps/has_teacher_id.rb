module TeacherTrainingAdviser::Steps
  class HasTeacherId < Wizard::Step
    attribute :has_id, :boolean

    validates :has_id, inclusion: { in: [true, false], message: "You must select either yes or no" }

    def reviewable_answers
      super.tap do |answers|
        answers["has_id"] = has_id ? "Yes" : "No"
      end
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]

      !returning_teacher
    end
  end
end
