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
      other_step(:have_a_degree).skipped?
    end
  end
end
