module TeacherTrainingAdviser::Steps
  class PreviousTeacherId < Wizard::Step
    attribute :teacher_id, :string

    def skipped?
      has_teacher_id_step = other_step(:has_teacher_id)
      has_teacher_id_skipped = has_teacher_id_step.skipped?
      has_id = has_teacher_id_step.has_id

      has_teacher_id_skipped || !has_id
    end
  end
end
