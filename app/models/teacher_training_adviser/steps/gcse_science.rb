module TeacherTrainingAdviser::Steps
  class GcseScience < Wizard::Step
    attribute :has_gcse_science_id, :integer

    validates :has_gcse_science_id, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

    OPTIONS = Crm::OPTIONS

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      phase_is_secondary = @store["preferred_education_phase_id"] == TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      no_gcse_maths_science = @store["has_gcse_maths_and_english_id"] == TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:no] &&
        @store["planning_to_retake_gcse_maths_and_english_id"] == TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:no]
      not_studying_or_have_a_degree = [
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying],
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree],
      ].none?(@store["degree_options"])

      returning_teacher || phase_is_secondary || no_gcse_maths_science || not_studying_or_have_a_degree
    end
  end
end
