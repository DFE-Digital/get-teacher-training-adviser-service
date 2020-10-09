module TeacherTrainingAdviser::Steps
  class PreviousTeacherId < Wizard::Step
    attribute :teacher_id, :string

    def skipped?
      has_teacher_id_skipped = @wizard.all_skipped?(HasTeacherId.key)
      has_id = @wizard.find(HasTeacherId.key).has_id

      has_teacher_id_skipped || !has_id
    end
  end
end
