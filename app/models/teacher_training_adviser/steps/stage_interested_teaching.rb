module TeacherTrainingAdviser::Steps
  class StageInterestedTeaching < Wizard::Step
    extend ApiOptions

    attribute :preferred_education_phase_id, :integer

    validates :preferred_education_phase_id, types: { method: :get_candidate_preferred_education_phases, message: "You must select either primary or secondary" }

    OPTIONS = { primary: 222_750_000, secondary: 222_750_001 }.freeze

    def reviewable_answers
      super.tap do |answers|
        answers["preferred_education_phase_id"] = OPTIONS.key(preferred_education_phase_id).to_s.capitalize
      end
    end

    def skipped?
      returning_teacher = @store["returning_to_teaching"]

      returning_teacher
    end
  end
end
