module TeacherTrainingAdviser::Steps
  class StageInterestedTeaching < Wizard::Step
    extend ApiOptions

    attribute :preferred_education_phase_id, :integer

    validates :preferred_education_phase_id, types: { method: :get_candidate_preferred_education_phases, message: "You must select either primary or secondary" }

    OPTIONS = { primary: 222_750_000, secondary: 222_750_001 }.freeze

    def skipped?
      @store["returning_to_teaching"]
    end
  end
end
