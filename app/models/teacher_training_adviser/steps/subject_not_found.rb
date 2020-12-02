module TeacherTrainingAdviser::Steps
  class SubjectNotFound < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      returning_teacher = other_step(:returning_teacher).returning_to_teaching
      preferred_teaching_subject_id = other_step(:subject_interested_teaching).preferred_teaching_subject_id
      subject_not_found = preferred_teaching_subject_id == TeacherTrainingAdviser::Steps::SubjectLikeToTeach::OTHER_SUBJECT_ID

      !(returning_teacher && subject_not_found)
    end
  end
end
