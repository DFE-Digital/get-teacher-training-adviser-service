module TeacherTrainingAdviser::Steps
  class SubjectTaught < Wizard::Step
    attribute :subject_taught_id, :string

    validates :subject_taught_id, types: { method: :get_teaching_subjects }

    def skipped?
      returning_teacher = @store["returning_to_teaching"]

      !returning_teacher
    end
  end
end
