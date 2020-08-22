module TeacherTrainingAdviser::Steps
  class QualificationRequired < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      @store["planning_to_retake_gcse_maths_and_english_id"] != TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:no] &&
        @store["planning_to_retake_gcse_science_id"] != TeacherTrainingAdviser::Steps::RetakeGcseScience::OPTIONS[:no]
    end
  end
end
