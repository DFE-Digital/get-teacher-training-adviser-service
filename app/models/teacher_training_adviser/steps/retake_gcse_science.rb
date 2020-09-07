module TeacherTrainingAdviser::Steps
  class RetakeGcseScience < Wizard::Step
    attribute :planning_to_retake_gcse_science_id, :integer

    validates :planning_to_retake_gcse_science_id, types: { method: :get_candidate_retake_gcse_status, message: "Select yes if you are planning to retake Science GCSE or equivalent" }

    OPTIONS = Crm::OPTIONS

    def reviewable_answers
      super.tap do |answers|
        answers["planning_to_retake_gcse_science_id"] =
          OPTIONS.key(planning_to_retake_gcse_science_id).to_s.capitalize
      end
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      equivalent_degree = @store["degree_options"] == TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      phase_is_secondary = @store["preferred_education_phase_id"] == TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary]
      has_gcse_science = @store["has_gcse_science_id"] != TeacherTrainingAdviser::Steps::GcseScience::OPTIONS[:no]
      not_retaking_gcse_maths_english = @store["planning_to_retake_gcse_maths_and_english_id"] == TeacherTrainingAdviser::Steps::RetakeGcseMathsEnglish::OPTIONS[:no]

      returning_teacher || equivalent_degree || phase_is_secondary || has_gcse_science || not_retaking_gcse_maths_english
    end
  end
end
