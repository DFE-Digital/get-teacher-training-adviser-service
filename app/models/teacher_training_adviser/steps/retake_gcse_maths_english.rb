module TeacherTrainingAdviser::Steps
  class RetakeGcseMathsEnglish < Wizard::Step
    attribute :planning_to_retake_gcse_maths_and_english_id, :integer

    validates :planning_to_retake_gcse_maths_and_english_id, types: { method: :get_candidate_retake_gcse_status, message: "Select yes if you are planning to retake English or Maths (or both) GCSE or equivalent" }

    OPTIONS = Crm::OPTIONS

    def reviewable_answers
      super.tap do |answers|
        answers["planning_to_retake_gcse_maths_and_english_id"] =
          OPTIONS.key(planning_to_retake_gcse_maths_and_english_id).to_s.capitalize
      end
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]
      equivalent_degree = @store["degree_options"] == TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      has_gcse_maths_english = @store["has_gcse_maths_and_english_id"] != TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS[:no]

      returning_teacher || equivalent_degree || has_gcse_maths_english
    end
  end
end
