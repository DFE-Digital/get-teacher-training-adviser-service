module TeacherTrainingAdviser::Steps
  class PreviousTeacherId < Wizard::Step
    attribute :teacher_id, :string

    def skipped?
      !@store["returning_to_teaching"] || @store["has_id"] != true
    end
  end
end
