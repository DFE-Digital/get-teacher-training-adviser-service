module TeacherTrainingAdviser::Steps
  class GcseScience < Wizard::Step
    attribute :has_gcse_science_id, :integer

    validates :has_gcse_science_id, types: { method: :get_candidate_retake_gcse_status }

    OPTIONS = Crm::OPTIONS

    def reviewable_answers
      super.tap do |answers|
        answers["has_gcse_science_id"] = OPTIONS.key(has_gcse_science_id).to_s.capitalize
      end
    end

    def skipped?
      gcse_maths_english_skipped = @wizard.all_skipped?(GcseMathsEnglish.key)
      preferred_education_phase_id = @wizard.find(StageInterestedTeaching.key).preferred_education_phase_id
      phase_is_secondary = preferred_education_phase_id == StageInterestedTeaching::OPTIONS[:secondary]
      has_gcse_maths_and_english_id = @wizard.find(GcseMathsEnglish.key).has_gcse_maths_and_english_id
      planning_to_retake_gcse_maths_and_english_id = @wizard.find(RetakeGcseMathsEnglish.key).planning_to_retake_gcse_maths_and_english_id
      no_gcse_maths_science = has_gcse_maths_and_english_id == GcseMathsEnglish::OPTIONS[:no] &&
        planning_to_retake_gcse_maths_and_english_id == RetakeGcseMathsEnglish::OPTIONS[:no]

      gcse_maths_english_skipped || no_gcse_maths_science || phase_is_secondary
    end
  end
end
