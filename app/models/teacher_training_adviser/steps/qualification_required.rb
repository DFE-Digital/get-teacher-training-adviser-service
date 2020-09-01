module TeacherTrainingAdviser::Steps
  class QualificationRequired < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      equivalent_degree = @store["degree_options"] == "equivalent"
      returning_teacher = @store["returning_to_teaching"]
      has_gcse_maths_english = @store["has_gcse_maths_and_english_id"] != TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:no]
      retaking_gcse_maths_english = @store["planning_to_retake_gcse_maths_and_english_id"] != TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:no]
      phase_is_primary = @store["preferred_education_phase_id"] == TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:primary]
      phase_is_secondary = @store["preferred_education_phase_id"] == TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      has_gcse_science = @store["has_gcse_science_id"] != TeacherTrainingAdviser::Steps::GcseScience::OPTIONS[:no]
      retaking_gcse_science = @store["planning_to_retake_gcse_science_id"] != TeacherTrainingAdviser::Steps::RetakeGcseScience::OPTIONS[:no]
      has_or_retaking_gcse_maths_english = has_gcse_maths_english || retaking_gcse_maths_english
      has_or_retaking_gcse_science = has_gcse_science || retaking_gcse_science

      equivalent_degree ||
        returning_teacher ||
        (phase_is_secondary && has_or_retaking_gcse_maths_english) ||
        (phase_is_primary && has_or_retaking_gcse_maths_english && has_or_retaking_gcse_science)
    end
  end
end
