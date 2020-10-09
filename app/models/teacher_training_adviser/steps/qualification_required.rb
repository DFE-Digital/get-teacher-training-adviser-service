module TeacherTrainingAdviser::Steps
  class QualificationRequired < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      retake_gcse_maths_english_skipped = @wizard.all_skipped?(RetakeGcseMathsEnglish.key)
      retake_gcse_science_skipped = @wizard.all_skipped?(RetakeGcseScience.key)
      planning_to_retake_gcse_maths_and_english_id = @wizard.find(RetakeGcseMathsEnglish.key).planning_to_retake_gcse_maths_and_english_id
      planning_to_retake_gcse_science_id = @wizard.find(RetakeGcseScience.key).planning_to_retake_gcse_science_id
      retaking_gcse_maths_english = planning_to_retake_gcse_maths_and_english_id != TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:no]
      retaking_gcse_science = planning_to_retake_gcse_science_id != TeacherTrainingAdviser::Steps::RetakeGcseScience::OPTIONS[:no]

      (retake_gcse_maths_english_skipped || retaking_gcse_maths_english) &&
        (retake_gcse_science_skipped || retaking_gcse_science)
    end
  end
end
