module TeacherTrainingAdviser::Steps
  class GcseMathsEnglish < Wizard::Step
    attribute :has_gcse_maths_and_english_id, :integer

    validates :has_gcse_maths_and_english_id, types: { method: :get_candidate_retake_gcse_status, message: "Select yes if you have grade 4(C) or above in English and Maths GCSE or equivalent" }

    OPTIONS = Crm::OPTIONS

    def reviewable_answers
      super.tap do |answers|
        answers["has_gcse_maths_and_english_id"] = OPTIONS.key(has_gcse_maths_and_english_id).to_s.capitalize
      end
    end

    def skipped?
      not_studying_or_have_a_degree = [
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying],
        TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree],
      ].none?(@store["degree_options"])

      not_studying_or_have_a_degree
    end
  end
end
