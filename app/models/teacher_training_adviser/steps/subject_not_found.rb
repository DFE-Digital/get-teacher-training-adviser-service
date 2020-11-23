module TeacherTrainingAdviser::Steps
  class SubjectNotFound < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      subject_not_found = @store["preferred_teaching_subject_id"] == TeacherTrainingAdviser::Steps::SubjectLikeToTeach::OTHER_SUBJECT_ID

      !(returning_teacher && subject_not_found)
    end
  end
end
