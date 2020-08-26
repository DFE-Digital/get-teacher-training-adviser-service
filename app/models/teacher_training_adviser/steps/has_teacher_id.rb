module TeacherTrainingAdviser::Steps
  class HasTeacherId < Wizard::Step
    attribute :has_id, :boolean

    validates :has_id, inclusion: { in: [true, false], message: "You must select either yes or no" }

    def skipped?
      returning_teacher = @store["returning_to_teaching"]

      !returning_teacher
    end
  end
end
