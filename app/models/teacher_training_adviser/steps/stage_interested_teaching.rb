module TeacherTrainingAdviser::Steps
  class StageInterestedTeaching < Wizard::Step
    extend ApiOptions

    attribute :preferred_education_phase_id, :integer

    validates :preferred_education_phase_id, types: { method: :get_candidate_preferred_education_phases }

    PRIMARY_SUBJECT_ID = "b02655a1-2afa-e811-a981-000d3a276620".freeze
    OPTIONS = { primary: 222_750_000, secondary: 222_750_001 }.freeze

    def reviewable_answers
      super.tap do |answers|
        answers["preferred_education_phase_id"] = OPTIONS.key(preferred_education_phase_id).to_s.capitalize
      end
    end

    def skipped?
      @wizard.all_skipped?(HaveADegree.key)
    end

    def export
      if preferred_education_phase_id == OPTIONS[:primary] && !skipped?
        super.merge("preferred_teaching_subject_id" => PRIMARY_SUBJECT_ID)
      else
        super
      end
    end
  end
end
