module TeacherTrainingAdviser::Steps
  class GcseMathsEnglish < GITWizard::Step
    attribute :has_gcse_maths_and_english_id, :integer

    validates :has_gcse_maths_and_english_id, pick_list_items: { method: :get_candidate_retake_gcse_status }

    OPTIONS = Crm::OPTIONS

    def reviewable_answers
      super.tap do |answers|
        answers["has_gcse_maths_and_english_id"] = OPTIONS.key(has_gcse_maths_and_english_id).to_s.capitalize
      end
    end

    def skipped?
      have_a_degree_step = other_step(:have_a_degree)
      have_a_degree_skipped = have_a_degree_step.skipped?
      not_have_a_degree = have_a_degree_step.degree_options != HaveADegree::DEGREE_OPTIONS[:yes]

      have_a_degree_skipped || not_have_a_degree
    end
  end
end
