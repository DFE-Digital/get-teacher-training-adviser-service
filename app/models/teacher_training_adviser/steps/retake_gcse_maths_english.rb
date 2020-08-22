module TeacherTrainingAdviser::Steps
  class RetakeGcseMathsEnglish < Wizard::Step
    attribute :planning_to_retake_gcse_maths_and_english_id, :integer

    validates :planning_to_retake_gcse_maths_and_english_id, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

    OPTIONS = Crm::OPTIONS

    def skipped?
      @store["returning_to_teaching"] ||
        @store["degree_options"] == TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent] ||
        @store["has_gcse_maths_and_english_id"] != Crm::OPTIONS[:no]
    end
  end
end
