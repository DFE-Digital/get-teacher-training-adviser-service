module TeacherTrainingAdviser::Steps
  class PreviousTeacherId < Wizard::Step
    attribute :teacher_id, :string

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      has_id = @store["has_id"] == true

      !returning_teacher || !has_id
    end
  end
end
