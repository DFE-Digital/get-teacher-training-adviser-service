module TeacherTrainingAdviser::Steps
  class AlreadySignedUp < Wizard::Step
    def skipped?
      !@store["already_subscribed_to_teacher_training_adviser"]
    end

    def can_proceed?
      false
    end
  end
end
