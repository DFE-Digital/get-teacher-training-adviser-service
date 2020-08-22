module TeacherTrainingAdviser::Steps
  class SubjectTaught < Wizard::Step
    attribute :subject_taught_id, :string

    validates :subject_taught_id, types: { method: :get_teaching_subjects }

    def skipped?
      !@store["returning_to_teaching"]
    end
  end
end
